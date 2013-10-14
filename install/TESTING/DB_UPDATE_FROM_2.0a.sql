ALTER TABLE `estoque` ADD `estoq_tag_inv` INT( 6 ) NULL ,
ADD `estoq_tag_inst` INT( 6 ) NULL ,
ADD `estoq_nf` INT( 15 ) NULL ,
ADD `estoq_warranty` INT( 3 ) NULL ,
ADD `estoq_value` FLOAT( 15 ) NULL ,
ADD `estoq_situac` INT( 2 ) NULL ,
ADD `estoq_data_compra` DATETIME NULL ,
ADD `estoq_ccusto` INT( 6 ) NULL ,
ADD `estoq_vendor` INT( 6 ) NULL ;

ALTER TABLE `estoque` ADD INDEX ( `estoq_tag_inv` , `estoq_tag_inst` ) ;

ALTER TABLE `estoque` ADD `estoq_partnumber` VARCHAR( 15 ) NULL ;

ALTER TABLE `estoque` ADD INDEX ( `estoq_partnumber` ) ;


CREATE TABLE `equipXpieces` (
`eqp_id` INT( 4 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`eqp_equip_inv` INT( 6 ) NOT NULL ,
`eqp_equip_inst` INT( 4 ) NOT NULL ,
`eqp_piece_id` INT( 6 ) NOT NULL ,
`eqp_piece_modelo_id` INT( 6 ) NOT NULL ,
INDEX ( `eqp_equip_inv` , `eqp_equip_inst` , `eqp_piece_id` )
) TYPE = MYISAM COMMENT = 'Tabela de associacao de equipamentos com componentes';


 CREATE TABLE `hist_pieces` (
`hp_id` INT( 6 ) NOT NULL AUTO_INCREMENT ,
`hp_piece_id` INT( 6 ) NOT NULL ,
`hp_piece_local` INT( 4 ) NULL ,
`hp_comp_inv` INT( 6 ) NULL ,
`hp_comp_inst` INT( 4 ) NULL ,
`hp_uid` INT( 6 ) NOT NULL ,
`hp_date` DATETIME NOT NULL ,
PRIMARY KEY ( `hp_id` ) ,
INDEX ( `hp_piece_id` , `hp_piece_local` , `hp_comp_inv` , `hp_comp_inst` )
) ENGINE = MYISAM CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT = 'Tabela de hist�rico de movimentac�es de pe�as avulsas';


 CREATE TABLE `email_warranty` (
`ew_id` INT( 6 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`ew_piece_type` INT( 1 ) NOT NULL DEFAULT '0',
`ew_piece_id` INT( 6 ) NOT NULL ,
`ew_sent_first_alert` BOOL NOT NULL DEFAULT '0',
`ew_sent_last_alert` BOOL NOT NULL DEFAULT '0',
INDEX ( `ew_piece_id` )
) TYPE = MYISAM COMMENT = 'Tabela de controle para envio de email sobre prazo de garantias';


ALTER TABLE `config` ADD `conf_days_bf` INT( 3 ) NOT NULL DEFAULT '30',
ADD `conf_wrty_area` INT( 4 ) NOT NULL DEFAULT '1';


INSERT INTO `msgconfig` (`msg_cod`, `msg_event`, `msg_fromname`, `msg_replyto`, `msg_subject`, `msg_body`, `msg_altbody`)
VALUES (NULL , 'mail-about-warranty', 'SISTEMA OCOMON', 'ocomon@yourdomain.com', 'OCOMON - VENCIMENTO DE GARANTIA', 'Aten&ccedil;&atilde;o: <br />Existem equipamentos com o prazo de garantia prestes a expirar.<br /><br />Tipo de equipamento: %tipo%<br />N&uacute;mero de s&eacute;rie: %serial%<br />Partnumber: %partnumber%<br />Modelo: %modelo%<br />Departamento: %local%<br />Fornecedor: %fornecedor%<br />Nota fiscal: %notafiscal%<br />Vencimento: %vencimento%', 'Aten��o:\r\nExistem equipamentos com o prazo de garantia prestes a expirar.\r\n\r\nTipo de equipamento: %tipo%\r\nN�mero de s�rie: %serial%\r\nPartnumber: %partnumber%\r\nModelo: %modelo%\r\nDepartamento: %local%\r\nFornecedor: %fornecedor%\r\nNota fiscal: %notafiscal%\r\nVencimento: %vencimento%');


ALTER TABLE `estoque` CHANGE `estoq_data_compra` `estoq_data_compra` DATETIME NULL DEFAULT '0000-00-00 00:00:00';


ALTER TABLE `config` ADD `conf_allow_reopen` TINYINT( 1 ) NOT NULL DEFAULT '1';

ALTER TABLE `config` ADD `conf_allow_date_edit` TINYINT( 1 ) NOT NULL DEFAULT '0';


ALTER TABLE `ocorrencias` DROP `operadorbkp` , DROP `abertoporbkp` ;

ALTER TABLE `ocorrencias` ADD `oco_scheduled` TINYINT( 1 ) NOT NULL DEFAULT '0',
ADD `oco_real_open_date` DATETIME NULL ;

ALTER TABLE `ocorrencias` ADD INDEX ( `oco_scheduled` ) ;

ALTER TABLE `configusercall` ADD `conf_scr_schedule` TINYINT( 1 ) NOT NULL DEFAULT '0';

ALTER TABLE `config` ADD `conf_schedule_status` INT( 4 ) NOT NULL DEFAULT '1';

ALTER TABLE `config` ADD `conf_schedule_status_2` INT( 4 ) NOT NULL DEFAULT '1';

ALTER TABLE `config` ADD `conf_foward_when_open` INT( 4 ) NOT NULL DEFAULT '1';

ALTER TABLE `configusercall` ADD `conf_scr_foward` TINYINT( 1 ) NOT NULL DEFAULT '0';

ALTER TABLE `hist_pieces` ADD `hp_technician` INT( 4 ) NULL ;

ALTER TABLE `hist_pieces` ADD INDEX ( `hp_technician` ) ;


INSERT INTO `msgconfig` (`msg_cod`, `msg_event`, `msg_fromname`, `msg_replyto`, `msg_subject`, `msg_body`, `msg_altbody`) VALUES (NULL, 'abertura-para-operador', 'SISTEMA OCOMON', 'ocomon@yourdomain.com', 'CHAMADO ABERTO PARA VOC�', '<span style="font-weight: bold;">SISTEMA OCOMON %versao%</span><br />Caro %operador%,<br />O chamado <span style="font-weight: bold;">%numero%</span> foi aberto e direcionado a voc&ecirc;.<br /><span style="font-weight: bold;">Descri&ccedil;&atilde;o: </span>%descricao%<br /><span style="font-weight: bold;">Contato: </span>%contato%<br /><span style="font-weight: bold;">Ramal:</span> %ramal%<br />Ocorr&ecirc;ncia aberta pelo operador: %aberto_por%<br />%site%', 'SISTEMA OCOMON %versao%\r\nCaro %operador%,\r\nO chamado %numero% foi aberto e direcionado a voc�.\r\nDescri��o: %descricao%\r\nContato: %contato%\r\nRamal: %ramal%\r\nOcorr�ncia aberta pelo operador: %aberto_por%\r\n%site%');

CREATE TABLE `script_solution` (
`script_cod` INT( 4 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`script_desc` TEXT NOT NULL
) TYPE = MYISAM COMMENT = 'Tabela de scripts de solucoes';

ALTER TABLE `ocorrencias` ADD `oco_script_sol` INT( 4 ) NULL ;

ALTER TABLE `ocorrencias` ADD INDEX ( `oco_script_sol` ) ;


CREATE TABLE `mail_templates` (
`tpl_cod` INT( 4 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`tpl_sigla` VARCHAR( 10 ) NOT NULL ,
`tpl_desc` TEXT NOT NULL ,
`tpl_msg_html` TEXT NOT NULL ,
`tpl_msg_text` TEXT NOT NULL
) TYPE = MYISAM COMMENT = 'Tabela de templates de e-mails';

ALTER TABLE `mail_templates` CHANGE `tpl_desc` `tpl_subject` VARCHAR( 100 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;

CREATE TABLE `mail_list` (
`ml_cod` INT( 4 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`ml_sigla` VARCHAR( 15 ) NOT NULL ,
`ml_desc` TEXT NOT NULL ,
`ml_address` TEXT NOT NULL
) TYPE = MYISAM COMMENT = 'Tabela de listas de distribuicao';

ALTER TABLE `mail_list` CHANGE `ml_address` `ml_addr_to` TEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE `mail_list` ADD `ml_addr_cc` TEXT NULL ;


CREATE TABLE `mail_hist` (
`mhist_cod` INT( 6 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`mhist_listname` VARCHAR( 150 ) NOT NULL ,
`mhist_address` TEXT NOT NULL ,
`mhist_body` TEXT NOT NULL ,
`mhist_date` DATETIME NOT NULL ,
`mhist_technician` INT( 4 ) NOT NULL ,
INDEX ( `mhist_technician` )
) TYPE = MYISAM COMMENT = 'Tabela de hist�rico de emails enviados';

ALTER TABLE `mail_hist` ADD `mhist_subject` VARCHAR( 40 ) NOT NULL AFTER `mhist_address` ;
ALTER TABLE `mail_hist` ADD `mhist_address_cc` TEXT NULL AFTER `mhist_address` ;

ALTER TABLE `mail_hist` ADD `mhist_oco` INT( 6 ) NOT NULL AFTER `mhist_cod` ;

ALTER TABLE `mail_hist` ADD INDEX ( `mhist_oco` ) ;

ALTER TABLE `mailconfig` ADD `mail_from_name` VARCHAR( 30 ) NOT NULL DEFAULT 'SISTEMA_OCOMON';
