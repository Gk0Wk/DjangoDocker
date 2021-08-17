# 使用python:slim就行，内置的是apt，先update一下，然后安装一些必须的
FROM python:slim
WORKDIR /server
ARG Asia/Shanghai
# django支持pymysql和mysqlclient，但是后者更快(缺点是安装需要gcc，相对步骤较多)。
# django2使用pymysql会出现str.decode的问题，3会修复，但还是推荐使用mysqlclient，也不需要改什么。
# 不过如果项目创建的时候只有pymysql，那么项目的__init__.py里面会有import pymysql; pymysql.install_as_MySQLdb()，把这个删了就会用mysqlclient。
RUN apt update && apt install -y default-libmysqlclient-dev gcc && pip --no-cache-dir install requests tensorflow pandas six numpy mysqlclient tushare SQLAlchemy Django==2.2.24 cryptography && apt remove -y gcc && apt clean && apt -y autoremove
