## Quick Installation

Install the template dependencies by running the `install` command:

```bash
box install
```

This will setup all the needed dependencies for each application template.  You can then start the embedded server:

```bash
box server start
```

Code to your liking and enjoy!

## Database Scripts
```sql
    create table ContentItem
    (
     id   int auto_increment
      primary key,
     name varchar(25) not null
    );

    create table LangTypes
    (
     id          int auto_increment
      primary key,
     code        varchar(10)  null,
     description varchar(255) null
    );

    create table Page
    (
     id   int auto_increment
      primary key,
     page varchar(255) null
    );

    create table PageContentItem
    (
     pageId        int not null,
     contentItemId int not null,
     constraint PageContentItem_ContentItem_id_fk
      foreign key (contentItemId) references ContentItem (id),
     constraint PageContentItem_Page_id_fk
      foreign key (pageId) references Page (id)
    );

    create table TranslatedItem
    (
     id            int auto_increment
      primary key,
     ContentItemId int  not null,
     LangTypeId    int  not null,
     value         text not null,
     constraint TranslatedItem_ContentItem_id_fk
      foreign key (ContentItemId) references ContentItem (id),
     constraint TranslatedItem_LangTypes_id_fk
      foreign key (LangTypeId) references LangTypes (id)
    );
```

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
