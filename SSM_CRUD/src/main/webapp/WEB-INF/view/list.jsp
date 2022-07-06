<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/7/4
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"   tagdir=""%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/htm;charset=TUF-8" >
    <title>员工列表</title>

<%--    以/为开头的路径以服务器为基准,否则以当前目录为基准--%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
    <%--   引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>

    <%--    引入样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" >
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"  ></script>


</head>
<body>

<div class="container">
<%--    第一行,标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
<%--    第二行,按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
<%--    第三行,表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                   <th>#</th>
                   <th>empName</th>
                   <th>gender</th>
                   <th>email</th>
                   <th>deptName</th>
                   <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp"></c:forEach>
                <tr>
                    <th>${emp.empId}</th>
                    <th>${emp.empName}</th>
                    <th>${emp.gender=="M"?"男":"女"}</th>
                    <th>${emp.email}</th>
                    <th>${emp.department.deptName}</th>
                    <th>测试</th>
                    <th>
                        <button  class="btn btn-primary btn-sm">编辑</button>
                        <button  class="btn btn-primary btn-sm">删除</button>
                    </th>
                </tr>
            </table>
        </div>
    </div>
<%--    第四行,分页信息拦--%>
    <div class="row">
<%--        分页文字信息--%>
        <div class="col-md-6">
            当前是${pageInfo.pageNum}也,共${pageInfo.pages},共${pageInfo.total}条记录
        </div>
<%--    分页条--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li href=" ">
                        首页
                    </li>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                        <li  class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if   test="${page_Num!=pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>


                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li href="${APP_PATH}/emps?pn=${pageInfo.pagTotal}">
                        末页
                    </li>

                </ul>
            </nav>
        </div>

    </div>

</div>



</body>
</html>
