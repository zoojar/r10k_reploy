# r10k_deploy plan
# Disables puppet agent and stops pupppetserver, deploys code via r10k and checks all code deployment filelists are identical
plan r10k_deploy (
  TargetSpec $targets,
  String $env            = '',   # default=all environments
  String $cmd_r10k_check = '/usr/bin/r10k deploy display --fetch',
  Boolean $check_r10k    = true,
  Boolean $manage_puppet = true, # manages puppet & puppetserver services for blocking sync deployment
  Boolean $md5check      = true,
  Boolean $verbose       = false,
){
  $_targets = get_targets($targets)
  $verbose_arg = $verbose ? { true => '-v', false => '' }
  $cmd_r10k_deploy = "/usr/bin/r10k deploy environment ${env} -m ${verbose_arg}"

  # Check r10k & control-repo connection
  if $check_r10k {
    run_command($cmd_r10k_check, $_targets, "Checking r10k connectivity, running: '${cmd_r10k_check}'")
  }

  # Ensure disabled and stopped: puppet and puppetserver
  if $manage_puppet {
    apply($_targets, '_description' => 'Ensuring puppet & puppetserver stopped & disabled.') {
      service { ['puppet', 'puppetserver']: ensure => false, enable => false }
    }
  }

  # Deploy code
  $results_deploy = run_command($cmd_r10k_deploy, $_targets, "Deploying code, running: '${cmd_r10k_deploy}'")

  if $md5check {
    ## Verify all targets have the same code, check md5 of filelist of codedir (exc. git & code_deploy.json)
    $results_md5 = run_task('r10k_deploy::get_deploy_md5', $_targets, '_catch_errors' => true)
    if $results_md5.ok {
      $md5s = $results_md5.ok_set.map |$result| { $result['md5'] }
      unless ($md5s.unique.length == 1) and ($md5s.unique[0].length == 32) {
        fail_plan("Deploys are out of sync: ${results_md5}.\
          Leaving puppet & puppetserver stopped & disabled,\
          failing plan. Deploy details: ${results_deploy}")
      }
    } else {
      fail_plan("failed to check code deploys: ${results_md5}\
        Deploy result details: ${results_deploy}")
    }
  }

  # Ensure enabled and running: puppet and puppetserver
  if $manage_puppet {
    apply($_targets, '_description' => 'Ensuring puppet & puppetserver running & enabled.') {
      service { 'puppetserver': ensure => true, enable => true }
      service { 'puppet': ensure => true, enable => true, require => Service['puppetserver'] }
    }
  }
  $_env = $env ? { '' => 'All', default => $env }
  $report = {
    'Status'         => 'Success',
    'Targets'        => $results_deploy.names,
    'Environment'    => $_env,
    'Deploy details' => $results_deploy,
  }
  return $report
}
