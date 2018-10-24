/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     2018-10-24 4:00:45 PM                        */
/*==============================================================*/


drop index CONFIG3_FK;

drop index CONFIG2_FK;

drop index CONFIG_FK;

drop index CONFIG_PK;

drop table CONFIG;

drop index EMAIL_PK;

drop table EMAIL;

drop index EMAILS2_FK;

drop index EMAILS_FK;

drop index EMAILS_PK;

drop table EMAILS;

drop index EMAIL_CONFIG_PK;

drop table EMAIL_CONFIG;

drop index PHONE_PK;

drop table PHONE;

drop index PHONES2_FK;

drop index PHONES_FK;

drop index PHONES_PK;

drop table PHONES;

drop index PHONE_CONFIG_PK;

drop table PHONE_CONFIG;

drop index USER_PK;

drop table "USER";

/*==============================================================*/
/* Table: CONFIG                                                */
/*==============================================================*/
create table CONFIG (
   CIP                  CHAR(8)              not null,
   EMAIL_CONFIG_ID      INT4                 not null,
   PHONE_CONFIG_ID      INT4                 not null,
   constraint PK_CONFIG primary key (CIP)
);

/*==============================================================*/
/* Index: CONFIG_PK                                             */
/*==============================================================*/
create unique index CONFIG_PK on CONFIG (
CIP
);

/*==============================================================*/
/* Index: CONFIG_FK                                             */
/*==============================================================*/
create  index CONFIG_FK on CONFIG (
CIP
);

/*==============================================================*/
/* Index: CONFIG2_FK                                            */
/*==============================================================*/
create  index CONFIG2_FK on CONFIG (
EMAIL_CONFIG_ID
);

/*==============================================================*/
/* Index: CONFIG3_FK                                            */
/*==============================================================*/
create  index CONFIG3_FK on CONFIG (
PHONE_CONFIG_ID
);

/*==============================================================*/
/* Table: EMAIL                                                 */
/*==============================================================*/
create table EMAIL (
   EMAIL_ADDRESS        VARCHAR(1024)        not null,
   constraint PK_EMAIL primary key (EMAIL_ADDRESS)
);

/*==============================================================*/
/* Index: EMAIL_PK                                              */
/*==============================================================*/
create unique index EMAIL_PK on EMAIL (
EMAIL_ADDRESS
);

/*==============================================================*/
/* Table: EMAILS                                                */
/*==============================================================*/
create table EMAILS (
   EMAIL_CONFIG_ID      INT4                 not null,
   EMAIL_ADDRESS        VARCHAR(1024)        not null,
   constraint PK_EMAILS primary key (EMAIL_CONFIG_ID, EMAIL_ADDRESS)
);

/*==============================================================*/
/* Index: EMAILS_PK                                             */
/*==============================================================*/
create unique index EMAILS_PK on EMAILS (
EMAIL_CONFIG_ID,
EMAIL_ADDRESS
);

/*==============================================================*/
/* Index: EMAILS_FK                                             */
/*==============================================================*/
create  index EMAILS_FK on EMAILS (
EMAIL_CONFIG_ID
);

/*==============================================================*/
/* Index: EMAILS2_FK                                            */
/*==============================================================*/
create  index EMAILS2_FK on EMAILS (
EMAIL_ADDRESS
);

/*==============================================================*/
/* Table: EMAIL_CONFIG                                          */
/*==============================================================*/
create table EMAIL_CONFIG (
   EMAIL_CONFIG_ID      SERIAL               not null,
   ACTIVE               BOOL                 not null,
   constraint PK_EMAIL_CONFIG primary key (EMAIL_CONFIG_ID)
);

/*==============================================================*/
/* Index: EMAIL_CONFIG_PK                                       */
/*==============================================================*/
create unique index EMAIL_CONFIG_PK on EMAIL_CONFIG (
EMAIL_CONFIG_ID
);

/*==============================================================*/
/* Table: PHONE                                                 */
/*==============================================================*/
create table PHONE (
   PHONE_NUMBER         VARCHAR(1024)        not null,
   constraint PK_PHONE primary key (PHONE_NUMBER)
);

/*==============================================================*/
/* Index: PHONE_PK                                              */
/*==============================================================*/
create unique index PHONE_PK on PHONE (
PHONE_NUMBER
);

/*==============================================================*/
/* Table: PHONES                                                */
/*==============================================================*/
create table PHONES (
   PHONE_CONFIG_ID      INT4                 not null,
   PHONE_NUMBER         VARCHAR(1024)        not null,
   constraint PK_PHONES primary key (PHONE_CONFIG_ID, PHONE_NUMBER)
);

/*==============================================================*/
/* Index: PHONES_PK                                             */
/*==============================================================*/
create unique index PHONES_PK on PHONES (
PHONE_CONFIG_ID,
PHONE_NUMBER
);

/*==============================================================*/
/* Index: PHONES_FK                                             */
/*==============================================================*/
create  index PHONES_FK on PHONES (
PHONE_CONFIG_ID
);

/*==============================================================*/
/* Index: PHONES2_FK                                            */
/*==============================================================*/
create  index PHONES2_FK on PHONES (
PHONE_NUMBER
);

/*==============================================================*/
/* Table: PHONE_CONFIG                                          */
/*==============================================================*/
create table PHONE_CONFIG (
   PHONE_CONFIG_ID      SERIAL               not null,
   ACTIVE               BOOL                 not null,
   constraint PK_PHONE_CONFIG primary key (PHONE_CONFIG_ID)
);

/*==============================================================*/
/* Index: PHONE_CONFIG_PK                                       */
/*==============================================================*/
create unique index PHONE_CONFIG_PK on PHONE_CONFIG (
PHONE_CONFIG_ID
);

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   CIP                  CHAR(8)              not null,
   FIRST_NAME           VARCHAR(50)          not null,
   LAST_NAME            VARCHAR(50)          not null,
   constraint PK_USER primary key (CIP)
);

/*==============================================================*/
/* Index: USER_PK                                               */
/*==============================================================*/
create unique index USER_PK on "USER" (
CIP
);

alter table CONFIG
   add constraint FK_CONFIG_CONFIG_USER foreign key (CIP)
      references "USER" (CIP)
      on delete restrict on update restrict;

alter table CONFIG
   add constraint FK_CONFIG_CONFIG2_EMAIL_CO foreign key (EMAIL_CONFIG_ID)
      references EMAIL_CONFIG (EMAIL_CONFIG_ID)
      on delete restrict on update restrict;

alter table CONFIG
   add constraint FK_CONFIG_CONFIG3_PHONE_CO foreign key (PHONE_CONFIG_ID)
      references PHONE_CONFIG (PHONE_CONFIG_ID)
      on delete restrict on update restrict;

alter table EMAILS
   add constraint FK_EMAILS_EMAILS_EMAIL_CO foreign key (EMAIL_CONFIG_ID)
      references EMAIL_CONFIG (EMAIL_CONFIG_ID)
      on delete restrict on update restrict;

alter table EMAILS
   add constraint FK_EMAILS_EMAILS2_EMAIL foreign key (EMAIL_ADDRESS)
      references EMAIL (EMAIL_ADDRESS)
      on delete restrict on update restrict;

alter table PHONES
   add constraint FK_PHONES_PHONES_PHONE_CO foreign key (PHONE_CONFIG_ID)
      references PHONE_CONFIG (PHONE_CONFIG_ID)
      on delete restrict on update restrict;

alter table PHONES
   add constraint FK_PHONES_PHONES2_PHONE foreign key (PHONE_NUMBER)
      references PHONE (PHONE_NUMBER)
      on delete restrict on update restrict;

