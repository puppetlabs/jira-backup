# Class: jirabackup
#
# This class installs and configures the jira-backup utility
#
# Parameters:
# 
#  db_host: (default '')
#  Set the postgres database host to connect to
#
#  db_pass: (default '')
#  Set the postgres database password
#
#  db_user: (default 'jira')
#  Set the postgres database user
#
#  db_name: (default 'jira')
#  Set the postgres database name
#
#  db_port: (default '2345')
# Set the postgres database port
#
#  backup_dir: (default '/var/atlassian/backups/jira')
#  Set the target backup directory for Jira attachments and postgres dumps
#
#  attachments_path: (default '/var/atlassian/application-data/jira/data/attachments')
#  Set the path to the Jira attachments
#
# Actions:
#  - Install jira-backup utility
#  - Manage the jira-backup configuration settings
#
# Requires:
#
# Sample Usage:
#
#   class { 'jirabackup':
#     db_host          => 'postgres.example.com',
#     db_pass          => 'database password',
#     db_user          => 'jira',
#     db_name          => 'jira',
#     backup_dir       => '/path/to/backup/output/dir',
#     attachments_path => '/path/to/jira/attachments'
#   }
#
class jirabackup (
  $db_host,
  $db_pass,
  $db_user          = 'jira',
  $db_name          = 'jira',
  $db_port          = '2345',
  $backup_dir       = '/var/atlassian/backups/jira',
  $attachments_path = '/var/atlassian/application-data/jira/data/attachments',
){
  file { '/usr/local/bin/jira-backup':
    ensure => present,
    group  => 'root',
    owner  => 'root',
    mode   => '0755',
    source => "puppet:///modules/jirabackup/jira-backup",
  }

  file { '/etc/jira-backup.conf':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('jirabackup/jira-backup.conf.erb'),
  }

  file { '/root/.pgpass':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('jirabackup/pgpass.erb'),
  }
}
