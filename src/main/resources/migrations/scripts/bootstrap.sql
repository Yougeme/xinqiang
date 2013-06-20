--//MySQL
--// Create Shiro Tables
--CREATE TABLE shiro_user_role (user_id BIGINT NOT NULL AUTO_INCREMENT, role_id BIGINT NOT NULL, PRIMARY KEY (user_id, role_id));
--CREATE TABLE shiro_role_permission (role_id BIGINT NOT NULL, permission VARCHAR(50) NOT NULL, PRIMARY KEY (role_id, permission));
--CREATE TABLE shiro_user (id BIGINT NOT NULL AUTO_INCREMENT, userid VARCHAR(100) NOT NULL UNIQUE, email VARCHAR(100) NOT NULL UNIQUE, passphrase VARCHAR(100) NOT NULL, salt VARCHAR(100) NOT NULL, date_created DATE NOT NULL, PRIMARY KEY (id));
--CREATE TABLE shiro_role (id BIGINT NOT NULL AUTO_INCREMENT, description VARCHAR(255), name VARCHAR(50) NOT NULL, PRIMARY KEY (id));
--ALTER TABLE shiro_role_permission ADD CONSTRAINT fk_shiro_role_id FOREIGN KEY (role_id) REFERENCES shiro_role (id);
--ALTER TABLE shiro_user_role ADD CONSTRAINT fk_shiro_user_role_user_id FOREIGN KEY (user_id) REFERENCES shiro_user (id);
--ALTER TABLE shiro_user_role ADD CONSTRAINT fk_shiro_user_role_role_id FOREIGN KEY (role_id) REFERENCES shiro_role (id);
--CREATE TABLE shiro_sequence (seq_name VARCHAR(50) NOT NULL, seq_count NUMERIC(38), PRIMARY KEY (seq_name));
--INSERT INTO shiro_sequence (seq_name, seq_count) VALUES ('shiro_user_seq', 0);
--INSERT INTO shiro_sequence (seq_name, seq_count) VALUES ('shiro_role_seq', 0);
----// Create a TestUser with a password of TestUserPassword
--INSERT INTO shiro_user (userid, passphrase, salt, email, date_created) VALUES ('TestUser', 'M1IFzumVt5cZznXtuE7uBS5xFE62vpcQY939F12ZTGQuJS9/vrnGKOiTu+cJGDEZO1XfJQYATVLO7qQTDuiCfA==', 'Cv2YXgmaudkMcw0/10T0jw==', 'TestUser@test.com', CURDATE()); 
--INSERT INTO shiro_role (description, name) VALUES ('Test Role', 'Test');
--INSERT INTO shiro_role_permission (role_id, permission) VALUES ( (SELECT id FROM shiro_role where name = 'Test' ), 'read');
--INSERT INTO shiro_user_role (user_id, role_id) VALUES ((SELECT id FROM shiro_user where userid = 'TestUser' ), (SELECT id FROM shiro_role where name = 'Test' ));

--//PostgreSQL
drop table if exists basic_role_menu_for_authorization;
drop table if exists basic_role_menu;
drop table if exists menu_permission;
drop table if exists basic_menu;
drop table if exists shiro_role_permission;
drop table if exists shiro_user_role;
drop table if exists shiro_role;
drop table if exists shiro_user;
drop table if exists basic_department;


--��֯������
create table basic_department (id serial not null, name varchar(50), parent_id bigint, order_number int default 999999, remark varchar(200), primary key(id));
alter table basic_department add constraint fk_basic_department_parent_id foreign key (parent_id) references basic_department (id);
comment on table basic_department is '��֯������';
comment on column basic_department.id is '����Ψһ��ʶ����0��1������';
comment on column basic_department.name is '�������ƣ���󳤶�Ϊ50��';
comment on column basic_department.parent_id is '��������id�������ͣ�';
comment on column basic_department.order_number is '�����������ţ�Ĭ��Ϊ99999����ֵԽС������ǰ�����ͣ�';
comment on column basic_department.remark is '���ű�ע��Ϣ����󳤶�Ϊ200��';
comment on constraint fk_basic_department_parent_id on basic_department is 'basic_department��parent_id�����Լ����ָ��basic_department��id';


--�û���
CREATE TABLE shiro_user (id SERIAL NOT NULL, userid VARCHAR(100) NOT NULL UNIQUE, name varchar(50), department_id bigint, email VARCHAR(100) NOT NULL UNIQUE, passphrase VARCHAR(100) NOT NULL, salt VARCHAR(100) NOT NULL, state boolean default true, date_created TIMESTAMP NOT NULL, remark varchar(200), PRIMARY KEY (id));
alter table shiro_user add constraint fk_shiro_user_department_id foreign key (department_id) references basic_department (id);
comment on table shiro_user is '�û���';
comment on column shiro_user.id is '�û�Ψһ��ʶ����0��1������';
comment on column shiro_user.userid is '�û���¼�˺ţ�����Ψһ�ԣ���󳤶�Ϊ100��';
comment on column shiro_user.name is '�û������������ظ�����󳤶�Ϊ50��';
comment on column shiro_user.department_id is '�������ţ������ͣ�';
comment on column shiro_user.email is 'email��ַ������Ψһ�ԣ���󳤶�Ϊ100��';
comment on column shiro_user.passphrase is '���루��������Ϊ8λ����Ϊ���ܺ�����֣���󳤶�Ϊ100��';
comment on column shiro_user.salt is '������ϣ���󳤶�Ϊ100��';
comment on column shiro_user.state is '�û�״̬��boolean���ͣ�trueΪ����״̬��falseΪ����״̬��Ĭ��Ϊtrue';
comment on column shiro_user.date_created is '�û�����ʱ��';
comment on column shiro_user.remark is '�û���ע';
comment on constraint fk_shiro_user_department_id on shiro_user is 'shiro_user.department_id�������ָ��basic_department';


--��ɫ��
CREATE TABLE shiro_role (id SERIAL NOT NULL, name VARCHAR(50) NOT NULL, description VARCHAR(200), department_id bigint, remark varchar(200), state boolean default true, PRIMARY KEY (id));
alter table shiro_role add constraint fk_shiro_role_department_id foreign key (department_id) references basic_department(id);
comment on table shiro_role is '��ɫ��';
comment on column shiro_role.id is '��ɫΨһ��ʶ����0��1������';
comment on column shiro_role.name is '��ɫ���ƣ���󳤶�Ϊ��ʮ��';
comment on column shiro_role.description is '��ɫ����(��󳤶�Ϊ200)';
comment on column shiro_role.department_id is '��������id�������ͣ�';
comment on column shiro_role.remark is '��ɫ��ע����󳤶�Ϊ200��';
comment on column shiro_role.state is '��ɫ״̬��boolean���ͣ�trueΪ����״̬��falseΪ����״̬��Ĭ��Ϊtrue';
comment on constraint fk_shiro_role_department_id on shiro_role is 'shiro_role.department_id�����ָ��basic_department.id';


--�û���ɫ������
CREATE TABLE shiro_user_role (user_id SERIAL NOT NULL , role_id BIGINT NOT NULL, PRIMARY KEY (user_id, role_id));
ALTER TABLE shiro_user_role ADD CONSTRAINT fk_shiro_user_role_user_id FOREIGN KEY (user_id) REFERENCES shiro_user (id);
ALTER TABLE shiro_user_role ADD CONSTRAINT fk_shiro_user_role_role_id FOREIGN KEY (role_id) REFERENCES shiro_role (id);
comment on table shiro_user_role is '�û�id�����ɫid������';
comment on column shiro_user_role.user_id is '�û�Ψһ��ʶ';
comment on column shiro_user_role.role_id is '��ɫΨһ��ʶ';
comment on constraint fk_shiro_user_role_user_id on shiro_user_role is 'shiro_user_role.user_id�����ָ��shiro_user.id';
comment on constraint fk_shiro_user_role_role_id on shiro_user_role is 'shiro_user_role.role_id�����ָ��shiro_role.id';


--��ɫȨ�޹�����
CREATE TABLE shiro_role_permission (role_id BIGINT NOT NULL, permission VARCHAR(100) NOT NULL, PRIMARY KEY (role_id, permission));
ALTER TABLE shiro_role_permission ADD CONSTRAINT fk_shiro_role_id FOREIGN KEY (role_id) REFERENCES shiro_role (id);
comment on table shiro_role_permission is '��ɫid��Ȩ�޹�����';
comment on column shiro_role_permission.role_id is '��ɫΨһ��ʶ';
comment on column shiro_role_permission.permission is 'Ȩ�ޣ�����ֻ������뵥��Ȩ�ޣ�����ж������Ҫ�ֿ������洢���С���󳤶�Ϊ100��';
comment on constraint fk_shiro_role_id on shiro_role_permission is 'shiro_role_permission.role_id�����ָ��shiro_role.id';


--�����˵���Ŀ��ϸ��
create table basic_menu (id serial not null, name varchar(20), parent_id bigint, link_url varchar(300) not null, order_number int default 999999, remark varchar(200), full_permission varchar(300), read_permission varchar(300), primary key(id));
ALTER TABLE basic_menu ADD CONSTRAINT fk_basic_menu_parent_id FOREIGN KEY (parent_id) REFERENCES basic_menu (id);
comment on table basic_menu is '�����˵���Ŀ��ϸ��';
comment on column basic_menu.id is '���β˵���ĿΨһ��ʶ';
comment on column basic_menu.name is '���β˵����ƣ��Ϊ20���ַ���';
comment on column basic_menu.parent_id is '�����˵�Ψһ��ʶ�������';
comment on column basic_menu.order_number is '�����������ţ�Ĭ��Ϊ99999����ֵԽС������ǰ�����ͣ�';
comment on column basic_menu.remark is '���β˵���ע˵��';
comment on column basic_menu.full_permission is '��ִ�����в���Ȩ�ޣ��ɷֺŷָ����磺account:create��account:read';
comment on column basic_menu.read_permission is '��ִ�ж�ȡ�Ĳ���Ȩ�ޣ��ɷֺŷָ����磺account:create��account:read';
comment on constraint fk_basic_menu_parent_id on basic_menu is 'basic_menu.parent_id�����ָ��basicmenu.id';


--�˵�Ȩ�ޱ�
create table basic_menu_permission(menu_id int not null, permission varchar(100) not null, primary key(menu_id, permission));
alter table basic_menu_permission add constraint fk_basic_menu_permission_menu_id foreign key (menu_id) references basic_menu(id);
comment on table basic_menu_permission is '�˵�Ȩ�ޱ���������ĳһ�˵��������ĵ�Ȩ��';
comment on column basic_menu_permission.menu_id is '�˵���ĿΨһ��ʶ';
comment on column basic_menu_permission.permission is 'Ȩ�ޣ�����ֻ������뵥��Ȩ�ޣ�����ж������Ҫ�ֿ������洢���С���󳤶�Ϊ100��';
comment on constraint fk_basic_menu_permission_menu_id on basic_menu_permission is 'basic_menu_permission.menu_id�����ָ��basic_menu.id';


--��ɫ�˵���
create table basic_role_menu(role_id int not null, menu_id int not null, primary key(role_id, menu_id));
alter table basic_role_menu add constraint fk_basic_role_menu_role_id foreign key (role_id) references shiro_role(id);
alter table basic_role_menu add constraint fk_basic_role_menu_menu_id foreign key (menu_id) references basic_menu(id);
comment on table basic_role_menu is '��ɫ���ù����Ĳ˵���';
comment on column basic_role_menu.role_id is '��ɫΨһ��ʶ�������';
comment on column basic_role_menu.menu_id is '�˵���ĿΨһ��ʶ�������';
comment on constraint fk_basic_role_menu_role_id on basic_role_menu is 'basic_role_menu.role_id�����ָ��shiro_role.id';
comment on constraint fk_basic_role_menu_menu_id on basic_role_menu is 'basic_role_menu.menu_id�����ָ��basic_menu.id';


--��ɫ����Ȩ�˵���
create table basic_role_menu_for_authorization(role_id int not null, menu_id int not null, primary key(role_id, menu_id));
alter table basic_role_menu_for_authorization add constraint fk_basic_role_menu_for_authorization_role_id foreign key (role_id) references shiro_role(id);
alter table basic_role_menu_for_authorization add constraint fk_basic_role_menu_for_authorization_menu_id foreign key (menu_id) references basic_menu(id);
comment on table basic_role_menu_for_authorization is '��ɫ���ù����Ĳ˵���';
comment on column basic_role_menu_for_authorization.role_id is '��ɫΨһ��ʶ�������';
comment on column basic_role_menu_for_authorization.menu_id is '�˵���ĿΨһ��ʶ�������';
comment on constraint fk_basic_role_menu_for_authorization_role_id on basic_role_menu_for_authorization is 'basic_role_menu_for_authorization.role_id�����ָ��shiro_role.id';
comment on constraint fk_basic_role_menu_for_authorization_menu_id on basic_role_menu_for_authorization is 'basic_role_menu_for_authorization.menu_id�����ָ��basic_menu.id';


--ͨ�������ֵ�
--create table system_data_dictionary 

--ȫ�ֲ�����
--create table system_global_parameter

--ϵͳ�쳣��¼
--create table system_exception



--// Create a TestUser with a password of TestUserPassword
--INSERT INTO shiro_user (userid, passphrase, salt, email, date_created) VALUES ('TestUser', 'M1IFzumVt5cZznXtuE7uBS5xFE62vpcQY939F12ZTGQuJS9/vrnGKOiTu+cJGDEZO1XfJQYATVLO7qQTDuiCfA==', 'Cv2YXgmaudkMcw0/10T0jw==', 'TestUser@test.com', NOW()); 
--INSERT INTO shiro_role (description, name) VALUES ('Test Role', 'Test');
--INSERT INTO shiro_role_permission (role_id, permission) VALUES ( (SELECT id FROM shiro_role where name = 'Test' ), 'read');
--INSERT INTO shiro_user_role (user_id, role_id) VALUES ((SELECT id FROM shiro_user where userid = 'TestUser' ), (SELECT id FROM shiro_role where name = 'Test' ));














