--
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--   http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied.  See the License for the
-- specific language governing permissions and limitations
-- under the License.
--

use app_catalog;

-- AIRAVATA-2768
alter table APPLICATION_INPUT modify METADATA VARCHAR(4096);

-- AIRAVATA-2758
-- Note: this doesn't really represent a schema change, rather some legacy database instances improperly had created these columns as NOT NULL
alter table COMPUTE_RESOURCE modify column CREATION_TIME TIMESTAMP DEFAULT NOW() null;
alter table COMPUTE_RESOURCE modify column CPUS_PER_NODE int default 0 null;
alter table COMPUTE_RESOURCE modify column DEFAULT_NODE_COUNT int default 0 null;
alter table COMPUTE_RESOURCE modify column DEFAULT_CPU_COUNT int default 0 null;
alter table COMPUTE_RESOURCE modify column DEFAULT_WALLTIME int default 0 null;
alter table COMPUTE_RESOURCE modify column UPDATE_TIME timestamp default '0000-00-00 00:00:00' null;

-- AIRAVATA-2827: OpenJPA 2.4.3 upgrade, convert BIT -> TINYINT(1)
alter table APPLICATION_OUTPUT modify column OUTPUT_STREAMING tinyint(1);
alter table APPLICATION_INTERFACE modify column ARCHIVE_WORKING_DIRECTORY tinyint(1);
alter table APPLICATION_INTERFACE modify column HAS_OPTIONAL_FILE_INPUTS tinyint(1);
alter table APPLICATION_DEPLOYMENT modify column EDITABLE_BY_USER tinyint(1);
alter table BATCH_QUEUE modify column IS_DEFAULT_QUEUE tinyint(1);
alter table COMPUTE_RESOURCE modify column GATEWAY_USAGE_REPORTING tinyint(1);
alter table USER_COMPUTE_RESOURCE_PREFERENCE modify column VALIDATED tinyint(1) default 0;

-- AIRAVATA-2872: NOT NULL foreign key columsn
set FOREIGN_KEY_CHECKS=0;
alter table HOST_ALIAS modify column RESOURCE_ID VARCHAR(255) NOT NULL;
alter table HOST_IPADDRESS modify column RESOURCE_ID VARCHAR(255) NOT NULL;
alter table GSISSH_EXPORT modify column SUBMISSION_ID VARCHAR(255) NOT NULL;
alter table GSISSH_PREJOBCOMMAND modify column SUBMISSION_ID VARCHAR(255) NOT NULL;
alter table GSISSH_POSTJOBCOMMAND modify column SUBMISSION_ID VARCHAR(255) NOT NULL;
alter table GLOBUS_GK_ENDPOINT modify column SUBMISSION_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_DEPLOYMENT modify column APP_MODULE_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_DEPLOYMENT modify column COMPUTE_HOSTID VARCHAR(255) NOT NULL;
alter table PREJOB_COMMAND modify column APPDEPLOYMENT_ID VARCHAR(255) NOT NULL;
alter table POSTJOB_COMMAND modify column APPDEPLOYMENT_ID VARCHAR(255) NOT NULL;
alter table LIBRARY_PREPAND_PATH modify column DEPLOYMENT_ID VARCHAR(255) NOT NULL;
alter table LIBRARY_APEND_PATH modify column DEPLOYMENT_ID VARCHAR(255) NOT NULL;
alter table APP_ENVIRONMENT modify column DEPLOYMENT_ID VARCHAR(255) NOT NULL;
alter table APP_MODULE_MAPPING modify column INTERFACE_ID VARCHAR(255) NOT NULL;
alter table APP_MODULE_MAPPING modify column MODULE_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_INPUT modify column INTERFACE_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_OUTPUT modify column INTERFACE_ID VARCHAR(255) NOT NULL;
alter table COMPUTE_RESOURCE_PREFERENCE modify column GATEWAY_ID VARCHAR(255) NOT NULL;
alter table COMPUTE_RESOURCE_PREFERENCE modify column RESOURCE_ID VARCHAR(255) NOT NULL;
alter table SSH_ACCOUNT_PROVISIONER_CONFIG modify column GATEWAY_ID VARCHAR(255) NOT NULL;
alter table SSH_ACCOUNT_PROVISIONER_CONFIG modify column RESOURCE_ID VARCHAR(255) NOT NULL;
-- alter table DATA_STORAGE_PREFERENCE modify column GATEWAY_ID VARCHAR(255) NOT NULL;
-- alter table WORKFLOW_INPUT modify column WF_TEMPLATE_ID VARCHAR(255) NOT NULL;
-- alter table WORKFLOW_OUTPUT modify column WF_TEMPLATE_ID VARCHAR(255) NOT NULL;
set FOREIGN_KEY_CHECKS=1;

-- AIRAVATA-2872: add missing column
alter table APP_ENVIRONMENT add column IF NOT EXISTS ENV_ORDER INTEGER;

-- AIRAVATA-2939: add NOT NULL constraints to DB fields that aren't in data model
alter table APPLICATION_MODULE modify column GATEWAY_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_MODULE modify column CREATION_TIME TIMESTAMP DEFAULT NOW() NOT NULL;
alter table APPLICATION_MODULE modify column UPDATE_TIME TIMESTAMP DEFAULT '0000-00-00 00:00:00' NOT NULL;
alter table APPLICATION_DEPLOYMENT modify column CREATION_TIME TIMESTAMP DEFAULT NOW() NOT NULL;
alter table APPLICATION_DEPLOYMENT modify column UPDATE_TIME TIMESTAMP DEFAULT '0000-00-00 00:00:00' NOT NULL;
alter table APPLICATION_DEPLOYMENT modify column GATEWAY_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_INTERFACE modify column GATEWAY_ID VARCHAR(255) NOT NULL;
alter table APPLICATION_INTERFACE modify column CREATION_TIME TIMESTAMP DEFAULT NOW() NOT NULL;
alter table APPLICATION_INTERFACE modify column UPDATE_TIME TIMESTAMP DEFAULT '0000-00-00 00:00:00' NOT NULL;

-- AIRAVATA-2938: bring database schema into sync with registry-refactoring DB init scripts
ALTER TABLE `JOB_MANAGER_COMMAND` ENGINE = InnoDB;
ALTER TABLE `HOST_IPADDRESS` ENGINE = InnoDB;
ALTER TABLE `GSISSH_SUBMISSION` ENGINE = InnoDB;
ALTER TABLE `HOST_ALIAS` ENGINE = InnoDB;
ALTER TABLE `JOB_SUBMISSION_INTERFACE` ENGINE = InnoDB;
ALTER TABLE `LIBRARY_PREPAND_PATH` ENGINE = InnoDB;
ALTER TABLE `LOCAL_SUBMISSION` ENGINE = InnoDB;
-- ALTER TABLE `DATA_STORAGE_PREFERENCE` ENGINE = InnoDB;
ALTER TABLE `COMPUTE_RESOURCE` ENGINE = InnoDB;
ALTER TABLE `COMPUTE_RESOURCE_FILE_SYSTEM` ENGINE = InnoDB;
ALTER TABLE `LIBRARY_APEND_PATH` ENGINE = InnoDB;
ALTER TABLE `GSISSH_EXPORT` ENGINE = InnoDB;
ALTER TABLE `GLOBUS_GK_ENDPOINT` ENGINE = InnoDB;
ALTER TABLE `GATEWAY_PROFILE` ENGINE = InnoDB;
ALTER TABLE `CONFIGURATION` ENGINE = InnoDB;
ALTER TABLE `DATA_MOVEMENT_INTERFACE` ENGINE = InnoDB;
ALTER TABLE `GLOBUS_SUBMISSION` ENGINE = InnoDB;
ALTER TABLE `GRIDFTP_DATA_MOVEMENT` ENGINE = InnoDB;
ALTER TABLE `GSISSH_POSTJOBCOMMAND` ENGINE = InnoDB;
ALTER TABLE `POSTJOB_COMMAND` ENGINE = InnoDB;
ALTER TABLE `GRIDFTP_ENDPOINT` ENGINE = InnoDB;
ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` ENGINE = InnoDB;
ALTER TABLE `GSISSH_PREJOBCOMMAND` ENGINE = InnoDB;
ALTER TABLE `LOCAL_DATA_MOVEMENT` ENGINE = InnoDB;
ALTER TABLE `APPLICATION_INPUT` ENGINE = InnoDB;
ALTER TABLE `APP_ENVIRONMENT` ENGINE = InnoDB;
ALTER TABLE `APP_MODULE_MAPPING` ENGINE = InnoDB;
ALTER TABLE `APPLICATION_OUTPUT` ENGINE = InnoDB;
ALTER TABLE `APPLICATION_MODULE` ENGINE = InnoDB;
ALTER TABLE `UNICORE_DATAMOVEMENT` ENGINE = InnoDB;
ALTER TABLE `APPLICATION_INTERFACE` ENGINE = InnoDB;
ALTER TABLE `UNICORE_SUBMISSION` ENGINE = InnoDB;
-- ALTER TABLE `WORKFLOW_INPUT` ENGINE = InnoDB;
-- ALTER TABLE `WORKFLOW` ENGINE = InnoDB;
ALTER TABLE `SSH_JOB_SUBMISSION` ENGINE = InnoDB;
-- ALTER TABLE `WORKFLOW_OUTPUT` ENGINE = InnoDB;
ALTER TABLE `APPLICATION_DEPLOYMENT` ENGINE = InnoDB;
ALTER TABLE `RESOURCE_JOB_MANAGER` ENGINE = InnoDB;
ALTER TABLE `PREJOB_COMMAND` ENGINE = InnoDB;
ALTER TABLE `SCP_DATA_MOVEMENT` ENGINE = InnoDB;
ALTER TABLE `BATCH_QUEUE` ENGINE = InnoDB;

-- Some of these column changes involve FK columns so need to temporarily turn off FK checks
set FOREIGN_KEY_CHECKS=0;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` CHANGE `RESERVATION_END_TIME` `RESERVATION_END_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00';
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` CHANGE `PREFERED_JOB_SUB_PROTOCOL` `PREFERED_JOB_SUB_PROTOCOL` varchar(255) DEFAULT NULL;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` CHANGE `PREFERED_DATA_MOVE_PROTOCOL` `PREFERED_DATA_MOVE_PROTOCOL` varchar(255) DEFAULT NULL;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` CHANGE `RESERVATION_START_TIME` `RESERVATION_START_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `STORAGE_INTERFACE` CHANGE `CREATION_TIME` `CREATION_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `STORAGE_INTERFACE` CHANGE `DATA_MOVEMENT_PROTOCOL` `DATA_MOVEMENT_PROTOCOL` varchar(255) NOT NULL;
ALTER TABLE `STORAGE_INTERFACE` CHANGE `UPDATE_TIME` `UPDATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00';

ALTER TABLE `LOCAL_SUBMISSION` CHANGE `SECURITY_PROTOCOL` `SECURITY_PROTOCOL` varchar(255) NOT NULL;

ALTER TABLE `PARSER` CHANGE `GATEWAY_ID` `GATEWAY_ID` varchar(255) NOT NULL;
ALTER TABLE `PARSER` DROP IF EXISTS `PARSER_INFO_ID`;

ALTER TABLE `PARSING_TEMPLATE` CHANGE `GATEWAY_ID` `GATEWAY_ID` varchar(255) NOT NULL;

ALTER TABLE `GROUP_RESOURCE_PROFILE` CHANGE `UPDATE_TIME` `UPDATE_TIME` bigint(20) NOT NULL;
ALTER TABLE `GROUP_RESOURCE_PROFILE` CHANGE `GATEWAY_ID` `GATEWAY_ID` varchar(255) NOT NULL;
ALTER TABLE `GROUP_RESOURCE_PROFILE` CHANGE `CREATION_TIME` `CREATION_TIME` bigint(20) NOT NULL;

ALTER TABLE `PARSING_TEMPLATE_INPUT` CHANGE `TARGET_PARSER_INPUT_ID` `TARGET_PARSER_INPUT_ID` varchar(255) NOT NULL;

ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` CHANGE `SSH_ACCOUNT_PROVISIONER_ADDITIONAL_INFO` `SSH_ACCOUNT_PROVISIONER_ADDITIONAL_INFO` varchar(1000) DEFAULT NULL;

ALTER TABLE `BATCH_QUEUE` CHANGE `QUEUE_SPECIFIC_MACROS` `QUEUE_SPECIFIC_MACROS` varchar(255) DEFAULT NULL;
ALTER TABLE `BATCH_QUEUE` CHANGE `DEFAULT_WALLTIME` `DEFAULT_WALLTIME` int(11) DEFAULT NULL;

ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` CHANGE `COMPUTE_RESOURCE_ID` `COMPUTE_RESOURCE_ID` varchar(255) NOT NULL;
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` CHANGE `GROUP_RESOURCE_PROFILE_ID` `GROUP_RESOURCE_PROFILE_ID` varchar(255) NOT NULL;
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` CHANGE `QUEUE_NAME` `QUEUE_NAME` varchar(255) NOT NULL;

ALTER TABLE `APPLICATION_OUTPUT` CHANGE `OUTPUT_STREAMING` `OUTPUT_STREAMING` smallint(6) DEFAULT NULL;

ALTER TABLE `APPLICATION_INTERFACE` CHANGE `ARCHIVE_WORKING_DIRECTORY` `ARCHIVE_WORKING_DIRECTORY` smallint(6) DEFAULT NULL;

ALTER TABLE `COMPUTE_RESOURCE` CHANGE `CPUS_PER_NODE` `CPUS_PER_NODE` int(11) DEFAULT NULL;
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `CREATION_TIME` `CREATION_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `DEFAULT_NODE_COUNT` `DEFAULT_NODE_COUNT` int(11) DEFAULT NULL;
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `UPDATE_TIME` `UPDATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00';
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `DEFAULT_CPU_COUNT` `DEFAULT_CPU_COUNT` int(11) DEFAULT NULL;
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `DEFAULT_WALLTIME` `DEFAULT_WALLTIME` int(11) DEFAULT NULL;
ALTER TABLE `COMPUTE_RESOURCE` CHANGE `GATEWAY_USAGE_MODULE_LOAD_CMD` `GATEWAY_USAGE_MODULE_LOAD_CMD` varchar(500) DEFAULT NULL;

ALTER TABLE `COMPUTE_RESOURCE_POLICY` CHANGE `GROUP_RESOURCE_PROFILE_ID` `GROUP_RESOURCE_PROFILE_ID` varchar(255) NOT NULL;
ALTER TABLE `COMPUTE_RESOURCE_POLICY` CHANGE `COMPUTE_RESOURCE_ID` `COMPUTE_RESOURCE_ID` varchar(255) NOT NULL;

ALTER TABLE `APPLICATION_INPUT` CHANGE `IS_READ_ONLY` `IS_READ_ONLY` smallint(6) DEFAULT NULL;

ALTER TABLE `COMPUTE_RESOURCE_POLICY_QUEUES` CHANGE `RESOURCE_POLICY_ID` `RESOURCE_POLICY_ID` varchar(255) NOT NULL;
ALTER TABLE `COMPUTE_RESOURCE_POLICY_QUEUES` CHANGE `QUEUE_NAME` `QUEUE_NAME` varchar(255) NOT NULL;

ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` CHANGE `SSH_ACCOUNT_PROVISIONER_ADDITIONAL_INFO` `SSH_ACCOUNT_PROVISIONER_ADDITIONAL_INFO` varchar(1000) DEFAULT NULL;
ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` CHANGE `RESERVATION_START_TIME` `RESERVATION_START_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` CHANGE `RESERVATION_END_TIME` `RESERVATION_END_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00';

ALTER TABLE `APPLICATION_DEPLOYMENT` CHANGE `DEFAULT_WALLTIME` `DEFAULT_WALLTIME` int(11) DEFAULT NULL;
ALTER TABLE `APPLICATION_DEPLOYMENT` CHANGE `DEFAULT_CPU_COUNT` `DEFAULT_CPU_COUNT` int(11) DEFAULT NULL;
ALTER TABLE `APPLICATION_DEPLOYMENT` CHANGE `DEFAULT_NODE_COUNT` `DEFAULT_NODE_COUNT` int(11) DEFAULT NULL;
set FOREIGN_KEY_CHECKS=1;

ALTER TABLE `GATEWAY_PROFILE` DROP IF EXISTS `DATA_STORAGE_HOST`;

-- This table was accidentally created by DB init script, but entity was mapped to STORAGE_PREFERENCE
DROP TABLE IF EXISTS `DATA_STORAGE_PREFERENCE`;

-- DROP TABLE IF EXISTS `WORKFLOW`, `WORKFLOW_INPUT`, `WORKFLOW_OUTPUT`;

-- keys indexes
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` ADD KEY IF NOT EXISTS `COMPUTE_RESOURCE_ID` (`COMPUTE_RESOURCE_ID`);
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` ADD KEY IF NOT EXISTS `GROUP_RESOURCE_PROFILE_ID` (`GROUP_RESOURCE_PROFILE_ID`);
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` DROP INDEX IF EXISTS `I_BTCHLCY_GROUPRESOURCEPROFILE`;
ALTER TABLE `COMPUTE_RESOURCE_POLICY_QUEUES` ADD PRIMARY KEY IF NOT EXISTS (`RESOURCE_POLICY_ID`,`QUEUE_NAME`);
ALTER TABLE `COMPUTE_RESOURCE_POLICY_QUEUES` DROP INDEX IF EXISTS `I_CMPT_QS_RESOURCE_POLICY_ID`;
ALTER TABLE `COMPUTE_RESOURCE_POLICY` ADD KEY IF NOT EXISTS `COMPUTE_RESOURCE_ID` (`COMPUTE_RESOURCE_ID`);
ALTER TABLE `COMPUTE_RESOURCE_POLICY` ADD KEY IF NOT EXISTS `GROUP_RESOURCE_PROFILE_ID` (`GROUP_RESOURCE_PROFILE_ID`);
ALTER TABLE `COMPUTE_RESOURCE_POLICY` DROP INDEX IF EXISTS `I_CMPTLCY_GROUPRESOURCEPROFILE`;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` ADD KEY IF NOT EXISTS `GROUP_RESOURCE_PROFILE_ID` (`GROUP_RESOURCE_PROFILE_ID`);
ALTER TABLE `GROUP_RESOURCE_PROFILE` ADD UNIQUE KEY IF NOT EXISTS `GATEWAY_ID` (`GATEWAY_ID`,`GROUP_RESOURCE_PROFILE_NAME`);
ALTER TABLE `GRP_SSH_ACC_PROV_CONFIG` ADD KEY IF NOT EXISTS `RESOURCE_ID` (`RESOURCE_ID`,`GROUP_RESOURCE_PROFILE_ID`);
ALTER TABLE `GRP_SSH_ACC_PROV_CONFIG` DROP INDEX IF EXISTS `CONFIG_NAME`;
ALTER TABLE `PARALLELISM_COMMAND` ADD PRIMARY KEY IF NOT EXISTS (`RESOURCE_JOB_MANAGER_ID`,`COMMAND_TYPE`);
ALTER TABLE `PARALLELISM_COMMAND` DROP INDEX IF EXISTS `COMMAND_TYPE`;
ALTER TABLE `PARSING_TEMPLATE_INPUT` ADD KEY IF NOT EXISTS `TARGET_PARSER_INPUT_ID` (`TARGET_PARSER_INPUT_ID`);
ALTER TABLE `PARSING_TEMPLATE_INPUT` DROP INDEX IF EXISTS `PARSER_INPUT_ID`;
ALTER TABLE `POSTJOB_COMMAND` ADD PRIMARY KEY IF NOT EXISTS (`APPDEPLOYMENT_ID`,`COMMAND`);
ALTER TABLE `POSTJOB_COMMAND` DROP INDEX IF EXISTS `COMMAND`;
ALTER TABLE `SSH_ACCOUNT_PROVISIONER_CONFIG` ADD PRIMARY KEY IF NOT EXISTS (`GATEWAY_ID`,`RESOURCE_ID`,`CONFIG_NAME`);
ALTER TABLE `SSH_ACCOUNT_PROVISIONER_CONFIG` DROP INDEX IF EXISTS `CONFIG_NAME`;
ALTER TABLE `STORAGE_INTERFACE` ADD PRIMARY KEY IF NOT EXISTS (`STORAGE_RESOURCE_ID`,`DATA_MOVEMENT_INTERFACE_ID`);
ALTER TABLE `STORAGE_INTERFACE` DROP INDEX IF EXISTS `DATA_MOVEMENT_INTERFACE_ID`;

-- Some of these FKs refer to non-existent data. Rather than cleaning up the orphaned data, we'll just turn off FK checks.
set FOREIGN_KEY_CHECKS=0;
-- create table delete_ids as select DEPLOYMENT_ID from APP_ENVIRONMENT a where NOT EXISTS (select 1 from APPLICATION_DEPLOYMENT where DEPLOYMENT_ID = ae.DEPLOYMENT_ID);
-- delete from APP_ENVIRONMENT where DEPLOYMENT_ID in (select DEPLOYMENT_ID from delete_ids);
ALTER TABLE `APP_ENVIRONMENT` ADD CONSTRAINT `APP_ENVIRONMENT_ibfk_1` FOREIGN KEY IF NOT EXISTS (`DEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select INTERFACE_ID from APP_MODULE_MAPPING a where NOT EXISTS (select 1 from APPLICATION_INTERFACE where INTERFACE_ID = a.INTERFACE_ID);
-- delete from APP_MODULE_MAPPING where INTERFACE_ID in (select INTERFACE_ID from delete_ids);
ALTER TABLE `APP_MODULE_MAPPING` ADD CONSTRAINT `APP_MODULE_MAPPING_ibfk_1` FOREIGN KEY IF NOT EXISTS (`INTERFACE_ID`) REFERENCES `APPLICATION_INTERFACE` (`INTERFACE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select MODULE_ID from APP_MODULE_MAPPING a where NOT EXISTS (select 1 from APPLICATION_MODULE where MODULE_ID = a.MODULE_ID);
-- delete from APP_MODULE_MAPPING where MODULE_ID in (select MODULE_ID from delete_ids);
ALTER TABLE `APP_MODULE_MAPPING` ADD CONSTRAINT `APP_MODULE_MAPPING_ibfk_2` FOREIGN KEY IF NOT EXISTS (`MODULE_ID`) REFERENCES `APPLICATION_MODULE` (`MODULE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select COMPUTE_HOSTID from APPLICATION_DEPLOYMENT a where NOT EXISTS (select 1 from COMPUTE_RESOURCE where RESOURCE_ID = a.COMPUTE_HOSTID);
-- delete from APPLICATION_DEPLOYMENT where COMPUTE_HOSTID in (select COMPUTE_HOSTID from delete_ids);
ALTER TABLE `APPLICATION_DEPLOYMENT` ADD CONSTRAINT `APPLICATION_DEPLOYMENT_ibfk_1` FOREIGN KEY IF NOT EXISTS (`COMPUTE_HOSTID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select APP_MODULE_ID from APPLICATION_DEPLOYMENT a where NOT EXISTS (select 1 from APPLICATION_MODULE where MODULE_ID = a.APP_MODULE_ID);
-- delete from APPLICATION_DEPLOYMENT where APP_MODULE_ID in (select APP_MODULE_ID from delete_ids);
ALTER TABLE `APPLICATION_DEPLOYMENT` ADD CONSTRAINT `APPLICATION_DEPLOYMENT_ibfk_2` FOREIGN KEY IF NOT EXISTS (`APP_MODULE_ID`) REFERENCES `APPLICATION_MODULE` (`MODULE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select INTERFACE_ID from APPLICATION_INPUT a where NOT EXISTS (select 1 from APPLICATION_INTERFACE where INTERFACE_ID = a.INTERFACE_ID);
-- delete from APPLICATION_INPUT where INTERFACE_ID in (select INTERFACE_ID from delete_ids);
ALTER TABLE `APPLICATION_INPUT` ADD CONSTRAINT `APPLICATION_INPUT_ibfk_1` FOREIGN KEY IF NOT EXISTS(`INTERFACE_ID`) REFERENCES `APPLICATION_INTERFACE` (`INTERFACE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

-- create table delete_ids as select INTERFACE_ID from APPLICATION_OUTPUT a where NOT EXISTS (select 1 from APPLICATION_INTERFACE where INTERFACE_ID = a.INTERFACE_ID);
-- delete from APPLICATION_OUTPUT where INTERFACE_ID in (select INTERFACE_ID from delete_ids);
ALTER TABLE `APPLICATION_OUTPUT` ADD CONSTRAINT `APPLICATION_OUTPUT_ibfk_1` FOREIGN KEY IF NOT EXISTS(`INTERFACE_ID`) REFERENCES `APPLICATION_INTERFACE` (`INTERFACE_ID`) ON DELETE CASCADE;
-- drop table delete_ids;

ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` ADD CONSTRAINT `BATCH_QUEUE_RESOURCE_POLICY_ibfk_1` FOREIGN KEY IF NOT EXISTS(`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `BATCH_QUEUE_RESOURCE_POLICY` ADD CONSTRAINT `BATCH_QUEUE_RESOURCE_POLICY_ibfk_2` FOREIGN KEY IF NOT EXISTS(`GROUP_RESOURCE_PROFILE_ID`) REFERENCES `GROUP_RESOURCE_PROFILE` (`GROUP_RESOURCE_PROFILE_ID`) ON DELETE CASCADE;
ALTER TABLE `BATCH_QUEUE` ADD CONSTRAINT `BATCH_QUEUE_ibfk_1` FOREIGN KEY IF NOT EXISTS(`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_FILE_SYSTEM` ADD CONSTRAINT `COMPUTE_RESOURCE_FILE_SYSTEM_ibfk_1` FOREIGN KEY IF NOT EXISTS(`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_POLICY_QUEUES` ADD CONSTRAINT `COMPUTE_RESOURCE_POLICY_QUEUES_ibfk_1` FOREIGN KEY IF NOT EXISTS(`RESOURCE_POLICY_ID`) REFERENCES `COMPUTE_RESOURCE_POLICY` (`RESOURCE_POLICY_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_POLICY` ADD CONSTRAINT `COMPUTE_RESOURCE_POLICY_ibfk_1` FOREIGN KEY IF NOT EXISTS(`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_POLICY` ADD CONSTRAINT `COMPUTE_RESOURCE_POLICY_ibfk_2` FOREIGN KEY IF NOT EXISTS(`GROUP_RESOURCE_PROFILE_ID`) REFERENCES `GROUP_RESOURCE_PROFILE` (`GROUP_RESOURCE_PROFILE_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` ADD CONSTRAINT `COMPUTE_RESOURCE_PREFERENCE_ibfk_1` FOREIGN KEY IF NOT EXISTS(`RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `COMPUTE_RESOURCE_PREFERENCE` ADD CONSTRAINT `COMPUTE_RESOURCE_PREFERENCE_ibfk_2` FOREIGN KEY IF NOT EXISTS(`GATEWAY_ID`) REFERENCES `GATEWAY_PROFILE` (`GATEWAY_ID`) ON DELETE CASCADE;
ALTER TABLE `DATA_MOVEMENT_INTERFACE` ADD CONSTRAINT `DATA_MOVEMENT_INTERFACE_ibfk_1` FOREIGN KEY IF NOT EXISTS(`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `GLOBUS_GK_ENDPOINT` ADD CONSTRAINT `GLOBUS_GK_ENDPOINT_ibfk_1` FOREIGN KEY IF NOT EXISTS(`SUBMISSION_ID`) REFERENCES `GLOBUS_SUBMISSION` (`SUBMISSION_ID`) ON DELETE CASCADE;
ALTER TABLE `GRIDFTP_ENDPOINT` ADD CONSTRAINT `GRIDFTP_ENDPOINT_ibfk_1` FOREIGN KEY IF NOT EXISTS(`DATA_MOVEMENT_INTERFACE_ID`) REFERENCES `GRIDFTP_DATA_MOVEMENT` (`DATA_MOVEMENT_INTERFACE_ID`) ON DELETE CASCADE;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` ADD CONSTRAINT `GROUP_COMPUTE_RESOURCE_PREFERENCE_ibfk_1` FOREIGN KEY IF NOT EXISTS(`RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `GROUP_COMPUTE_RESOURCE_PREFERENCE` ADD CONSTRAINT `GROUP_COMPUTE_RESOURCE_PREFERENCE_ibfk_2` FOREIGN KEY IF NOT EXISTS(`GROUP_RESOURCE_PROFILE_ID`) REFERENCES `GROUP_RESOURCE_PROFILE` (`GROUP_RESOURCE_PROFILE_ID`) ON DELETE CASCADE;
ALTER TABLE `GRP_SSH_ACC_PROV_CONFIG` ADD CONSTRAINT `GRP_SSH_ACC_PROV_CONFIG_ibfk_1` FOREIGN KEY IF NOT EXISTS(`RESOURCE_ID`, `GROUP_RESOURCE_PROFILE_ID`) REFERENCES `GROUP_COMPUTE_RESOURCE_PREFERENCE` (`RESOURCE_ID`, `GROUP_RESOURCE_PROFILE_ID`) ON DELETE CASCADE;
ALTER TABLE `GSISSH_EXPORT` ADD CONSTRAINT `GSISSH_EXPORT_ibfk_1` FOREIGN KEY IF NOT EXISTS(`SUBMISSION_ID`) REFERENCES `GSISSH_SUBMISSION` (`SUBMISSION_ID`) ON DELETE CASCADE;
ALTER TABLE `GSISSH_POSTJOBCOMMAND` ADD CONSTRAINT `GSISSH_POSTJOBCOMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS(`SUBMISSION_ID`) REFERENCES `GSISSH_SUBMISSION` (`SUBMISSION_ID`) ON DELETE CASCADE;
ALTER TABLE `GSISSH_PREJOBCOMMAND` ADD CONSTRAINT `GSISSH_PREJOBCOMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS(`SUBMISSION_ID`) REFERENCES `GSISSH_SUBMISSION` (`SUBMISSION_ID`) ON DELETE CASCADE;
ALTER TABLE `HOST_ALIAS` ADD CONSTRAINT `HOST_ALIAS_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `HOST_IPADDRESS` ADD CONSTRAINT `HOST_IPADDRESS_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `JOB_MANAGER_COMMAND` ADD CONSTRAINT `JOB_MANAGER_COMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_JOB_MANAGER_ID`) REFERENCES `RESOURCE_JOB_MANAGER` (`RESOURCE_JOB_MANAGER_ID`) ON DELETE CASCADE;
ALTER TABLE `JOB_SUBMISSION_INTERFACE` ADD CONSTRAINT `JOB_SUBMISSION_INTERFACE_ibfk_1` FOREIGN KEY IF NOT EXISTS (`COMPUTE_RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE` (`RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `LIBRARY_APEND_PATH` ADD CONSTRAINT `LIBRARY_APEND_PATH_ibfk_1` FOREIGN KEY IF NOT EXISTS (`DEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
ALTER TABLE `LIBRARY_PREPAND_PATH` ADD CONSTRAINT `LIBRARY_PREPAND_PATH_ibfk_1` FOREIGN KEY IF NOT EXISTS (`DEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
ALTER TABLE `LOCAL_SUBMISSION` ADD CONSTRAINT `LOCAL_SUBMISSION_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_JOB_MANAGER_ID`) REFERENCES `RESOURCE_JOB_MANAGER` (`RESOURCE_JOB_MANAGER_ID`);
ALTER TABLE `MODULE_LOAD_CMD` ADD CONSTRAINT `MODULE_LOAD_CMD_ibfk_1` FOREIGN KEY IF NOT EXISTS (`APP_DEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
ALTER TABLE `PARALLELISM_COMMAND` ADD CONSTRAINT `PARALLELISM_COMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_JOB_MANAGER_ID`) REFERENCES `RESOURCE_JOB_MANAGER` (`RESOURCE_JOB_MANAGER_ID`) ON DELETE CASCADE;
ALTER TABLE `POSTJOB_COMMAND` ADD CONSTRAINT `POSTJOB_COMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS (`APPDEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
ALTER TABLE `PREJOB_COMMAND` ADD CONSTRAINT `PREJOB_COMMAND_ibfk_1` FOREIGN KEY IF NOT EXISTS (`APPDEPLOYMENT_ID`) REFERENCES `APPLICATION_DEPLOYMENT` (`DEPLOYMENT_ID`) ON DELETE CASCADE;
ALTER TABLE `SSH_ACCOUNT_PROVISIONER_CONFIG` ADD CONSTRAINT `SSH_ACCOUNT_PROVISIONER_CONFIG_ibfk_1` FOREIGN KEY IF NOT EXISTS (`GATEWAY_ID`, `RESOURCE_ID`) REFERENCES `COMPUTE_RESOURCE_PREFERENCE` (`GATEWAY_ID`, `RESOURCE_ID`) ON DELETE CASCADE;
ALTER TABLE `SSH_JOB_SUBMISSION` ADD CONSTRAINT `SSH_JOB_SUBMISSION_ibfk_1` FOREIGN KEY IF NOT EXISTS (`RESOURCE_JOB_MANAGER_ID`) REFERENCES `RESOURCE_JOB_MANAGER` (`RESOURCE_JOB_MANAGER_ID`);
-- Note: to deal with STORAGE_INTERFACEs that reference non-existent STORAGE_RESOURCEs, use the following to clean up orphans
-- MariaDB [app_catalog]> create table temp1 as select STORAGE_RESOURCE_ID from STORAGE_INTERFACE si where not exists (select 1 from STORAGE_RESOURCE sr where sr.STORAGE_RESOURCE_ID = si.STORAGE_RESOURCE_ID);
-- MariaDB [app_catalog]> delete from STORAGE_INTERFACE where STORAGE_RESOURCE_ID in (select STORAGE_RESOURCE_ID from temp1);
ALTER TABLE `STORAGE_INTERFACE` ADD CONSTRAINT `STORAGE_INTERFACE_ibfk_1` FOREIGN KEY IF NOT EXISTS (`STORAGE_RESOURCE_ID`) REFERENCES `STORAGE_RESOURCE` (`STORAGE_RESOURCE_ID`) ON DELETE CASCADE;
set FOREIGN_KEY_CHECKS=1;

-- Older tables that no longer exist, or don't exist with those names
DROP TABLE IF EXISTS `DATA_STORAGE_INTERFACE`;
DROP TABLE IF EXISTS `GATEWAY_CLIENT_CREDENTIAL`;

-- misnamed column. This migration was only needed in development environment where code with old column name was deployed.
-- UPDATE PARSER_CONNECTOR_INPUT set PARSER_OUTPUT_ID = PARENT_OUTPUT_ID;
-- ALTER TABLE `PARSER_CONNECTOR_INPUT` DROP IF EXISTS `PARENT_OUTPUT_ID`;
-- ALTER TABLE `PARSING_TEMPLATE_INPUT` DROP IF EXISTS `PARSER_INPUT_ID`;

ALTER TABLE `UNICORE_DATAMOVEMENT` DROP IF EXISTS `SECURITY_PROTOCOL`;
