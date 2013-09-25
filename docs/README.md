# Jira Backup

A simple shell script to backup Jira instances according to Atlassian best practices outlined in [Backing Up Data](https://confluence.atlassian.com/display/JIRA052/Backing+Up+Data).

## Features

 * Backup Jira attachments
 * Backup Jira database using pg_dump

## Configuration

The jira-backup script requires the following configuration file:

    /etc/jira-backup.conf

If the configuration file is missing you will get the following error:

    root@jira:~# jira-backup 
	Error: /etc/jira-backup.conf missing

	root@jira:~# echo $?
	1

An example configuration can be found in the configs directory.

## Installation

I'm in the process of creating a debian package for `jira-backup`, until then:

    cp jira-backup /usr/local/bin/jira-backup
	chmod +x /usr/local/bin/jira-backup

Then create the `/etc/jira-backup.conf` file.

    vim /etc/jira-backup.conf

	BACKUP_DIR='/var/atlassian/backups/jira'

    # Attachments
    ATTACHMENTS_PATH='/var/atlassian/application-data/jira/data/attachments'

    # Database
    DB_NAME='jira'
    DB_HOST='database hostname'
    DB_USER='jira'
    DB_PASS='databae password'


## Usage

	root@jira:~# /usr/local/bin/jira-backup
	Backing up Jira
	Backing up Jira attachments
	/bin/tar: Removing leading `/' from member names
	Created /var/atlassian/backups/jira/jira-attachments-2013-07-11-09-50.tar
	Dumping Jira database
	Created /var/atlassian/backups/jira/jira-database-dump-2013-07-11-09-50.sql

All backups end up under `/var/atlassian/backups`; this can be changed by setting the BACKUP_DIR in `/etc/jira-backup.conf`
