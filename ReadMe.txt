2018.12.06 - Kikyou
项目整体框架，实现了基本的用户登陆、注册、权限管理、上传课程、管理评论
手动在数据库中设置某个用户的admin为true后，该用户具有管理员权限，可以删除其他评论、用户、课程，可以上传课程文件
目前的数据库结构(Schema)：
    users: 
        CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "email" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar, "remember_digest" varchar, "admin" boolean DEFAULT 'f');
        CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
        CREATE UNIQUE INDEX "index_users_on_name" ON "users" ("name");
    courses:
        CREATE TABLE "courses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" text, "teacher" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
    comments:
        CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" text, "user_id" integer, "course_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
        CREATE INDEX "index_comments_on_user_id" ON "comments" ("user_id");
        CREATE INDEX "index_comments_on_course_id" ON "comments" ("course_id");
ToDo:
    1、数据库结构还不完善，user course comment 等需要更多字段信息
    2、没有实现用户信息编辑
    3、课程评论需要更多信息：评分、推荐/不推荐
    4、用户关注功能、课程推荐功能....
    5、网页样式不完善
    。。。。。。（太多了，毕竟这是第一次提交）
    