
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="TUF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <jsp:forward page="/emps"></jsp:forward>
<%--   引入jquery--%>
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<%--    引入样式--%>
    <link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" >
    <script src="${APP_PATH }/tatic/bootstrap-3.4.1-dist/js/bootstrap.min.js"  ></script>
</head>
<body>

<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>






<%--搭建显示页面--%>
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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--    第三行,表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">

                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"></th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
        </div>
    </div>

<%--    显示分页信息--%>
    <div class="=row">
<%--    分页文字信息    --%>
        <div class="col-md-6" id="page-info_area"></div>
<%--         分页条信息    --%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

    <script type="text/javascript">
        // 定义总记录数和当前页
        var totalRecord,currentPage
        //发送ajax请求,获取分页数据
        $(function () {
            //DNA什么都不操作是就执行该哈数,跳转到到第一页,由下面的函数处理
            to_page(1);
        })
//to_page是下面的点击连接,执行该函数,该函数中又执行其他的3个函数来获取相应页面内的信息
        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                date:"pn="+pn,
                type:"get",
                success:function (result) {
                    //解析并显示员工数据
                    build_emps_table(result);
                    //解析并显示分页信息
                    build_page_info(result);
                    //解析并显示分页数据
                    build_page_nav(result);
                }
            });

        }


        //表单信息
        function build_emps_table(result) {
            //清空table表格,,先获取id为emps_tablen的表格的tbody标签
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            使用each遍历emps元素,并放进单元格
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'> </td>")
               //向单元格添加数据
                var empId=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.deptName);

                // addClass中的两个class是还是上面的按钮的class
                var editBtn=$("<button></button>").addClass("btn btn-primary  btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("编辑");

                //给编辑按钮天机一个属性,来表示当前的id,下面的500行左右方法用id来后去员工信息
                editBtn.attr("edit-id",empId)

//向<button>中添加<span>,<span>添加
                var delBtn=$("<button></button>").addClass("btn btn-danger  btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

                delBtn.attr("del-id",empId)

                //把上面两个按钮添加进同一个<td>标签
                 var btnTd=$("<td></td>").append(editBtn).append(delBtn)

                //把上面 的单元格放进 emp_table表格的tbody得到 <tr>标签
                $("<tr></tr>").append(empId)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emp_table tbody")

            })
        }


//解析分页显示信息
        function  build_page_info(result) {


            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页数,总"+
                      result.extend.pageInfo.pages+"页,总"+
                        result.extend.pageInfo.total+"条记录")
            totalRecord=result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //解析分页条,判断是否能带上一页或下一页
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul= $("<ul></ul>").addClass("pagination");


            //添加首页和上一页按钮
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            ////如果没有上一页,则让两个按钮失效
            if(result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    to_page(1)

                })
                prePageLi.click(function () {
                    to_page(result.extend.pagrInfo.pageNum-1)
                })
            }

            //添加尾页和下一页按钮,店即将按钮执行相应函数实现跳转
            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            ////如果没有下一页,则让两个按钮失效
            if(result.extend.pageInfo.hasLastPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                nextPageLi.click(function () {
                    to_page(result.pageInfo.pageNum+1)

                })
                lastPageLi.click(function () {
                     to_page(result.extend.page)
                })
            }


            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);

            //遍历页码给ul添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                //当点击该标签,会得到所点击的页面页码item,执行下面的函数,进行相应 的跳转
                var numLi=$("<li></li>").append($("<a></a>").append(item))
                if(result.extend.pageInfo.pageNum==item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item)

                })
                ul.append(numLi);
            })

            //添加一下一页和末页
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area")


            //清空表单样式及内容
            function reset_form(ele){
                $(ele)[0].reset();
                //清空表单中所有元素的样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }




            //点击新增按钮弹出模态框。

            $("#emp_add_modal_btn").click(function () {
                //清除表单数据,调用上方的函数,并传入要清空的表单
                reset_form("#empAddModal form")
                //获取部门信息显在下拉列表,需要先使用下面的函数获取部门信息
                getDepts("#empAddModal select");
                //弹出模态框
                $("empAddModal").modal({
                    backdrop:"static"
                })

            })




            // 查询部门信息显示到id为ele下拉列表

            function getDepts(ele) {
                $(ele).empty();
                //向服务器发送ajax请求,${APP_PATH}/depts,,相应的控制器会处理该请求
                $.ajax({
                    url:"${APP_PATH}/depts",
                    type:"GET",

                    success:function (result) {
                        //遍历result.extend.depts中的信息,每次遍历都只要deptName添加到<option>中
                        $.each(result.extend.depts,function () {
                          var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                          //把封装了option的optionEle添加到
                          optionEle.appendTo(ele);
                        })

                    }
                })

            }

            //校验表单数据
            function validate_add_form() {

                //校验应户名
                //使用正则来检验拿到的数据,,empName_add_input是name所在标签的id
                var empName=$("#empName_add_input").val()
                var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/
                if(!regName.test(empName)){
                    //提示错误信息
                    //调用下方的方法,且必须传递三个参数
                    show_validate_msg("#empName_add_input","error","用户名可以是2--5 位的中文或6到16的字符")
                    return false;
                }else{
                    show_validate_msg("#empName_add_input","success","")
                }

                //校验邮箱信息
                var email=$("#email_add_input").val()
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    //提示错误信息
                    show_validate_msg("#email_add_input","error","邮箱格式不正确")
                    return false;
                }else{
                    show_validate_msg("#email_ad_inpput","success","")
                }


                return true;


            }




            //显示校验结果的提示信息
            function show_validate_msg(ele,status,msg) {
                //清除当前的校验状态
                $(ele).parent().removeClass("has-success has-error")
                $(ele).next("span").text("")
                //如果传递的是success ,则在当前的父标签中adclass
                //并且 在当前标签的下面卡皮一个span空间,并显示msg提示信息
                if ("success"==status){
                    $(ele).parent().addClass("has-success")
                    $(ele).next("span").text(msg)
                }else if("error" == status){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }

            }

            //使用ajax校验用户名
            $("#empName_add_input").change(function () {

                var empName=this.value
                //向控制器发送请求URL是超连接,data是发送的数据,且使用post传输
                $.ajax({
                    url:"${APP_path}/checkuser",
                    data:"empName="+empName,
                    type:"POST",
                    //上述操作成功之后 的方法,即调用保存方法
                    success:function (result) {
                        if(result.code==100){
                            show_validate_msg("#empName_add_input","success","用户名可用")
                            $("#emp_save_btn").attr("ajax-va","success")
                        }else{
                            show_validate_msg("#empName_add_input","error","用户名可用")
                            $("#emp_save_btn").attr("ajax-va","error")
                        }


                    }
                })

            })


            //保存员工
            $("#emp_save_btn").click(function () {
                //先对提交的数据进行 判断 在提交给服务器进行保存

                //validate_add_form是方法返回值
                if(!validate_add_form()){
                    return false;
                }
                // "ajax-va","error"上面443行方法的两个参数
                //this表示当前标签对象,记不button对象
                if($(this).attr("java-va")=="error"){
                    return false
                }


                //如果上述两种情况都不是.则发送ajax请求保存员工
                $.ajax({
                    url:"${APP_PATH}/emp",
                    type:"POST",
                    data:$("#empAddModal form").serialize(),

                    success:function (result) {
                        if(result.code==100){
                        $("#empAddModal").modal('hidden');
                        to_page(totalRecord);

                        } else {
                            //判断邮箱是否定义
                            if (undefined != result.extend.errorFields.email) {
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                            }
                            if(undefined != result.extend.errorFields.empName){
                                //显示员工名字的错误信息
                                show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                            }
                        }
                    }
                })

            })




            //给编辑按钮绑定 点击事件
            //jquery新版没有live，使用on进行替代
            $(document).on("click",".edit_btn",function () {

                //从empUpdateModal中获取select标签中的id,查询部门信息
                getDepts("empUpdateModal select");
                //this是当前使用的标签(即empUpdateModal所在标签)的对象,edit-id是giant子标签编辑按钮的是属性值
                getEmp($(this).attr("edit-id"))
                //用对象$(this).attr("edit_id")获取该按钮的id值,然后付给模态框的更新update按钮
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit_id"));
                $("#empUpdateModal").modal({
                    backdrop:"static"
                })

            })


            //根据id查询员工信息并封装进empData,,
            function getEmp(id) {
                $.ajax({
                    url:"${APP_PATH}/emp/"+id,
                    type:"GET",
                    success:function (result) {
                        var empData=result.extend.emp;
                        //把获取到的数据放入修改模态框的相应标签
                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select  ").val([empData.dId]);

                    }
                })

            }


            $("#emp_update_btn").click(function () {
                //验证邮箱是否合法
                var email=$("#email_update_input").val()
                var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email_update_input","error","邮箱格式 不正确");
                    return false;
                }else{
                    show_validate_msg("#email_update_input","success","  ")
                }

                //发送ajax请求保存数据
                //把修改模态框的form表单的数据发送给控制器
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),

                    success:function (result) {
                        //关闭对话框
                        $("#empUpdateModal").modal('hidden')

                        to_page(currentPage)
                    }
                })


            })



            //单个删除
            $(document).on("click",".delete_btn",function () {
                //弹出删除对话框,并获取突然标签的第二个内容即empname,和自己添加得 id属性值
                var empName=$(this).parent("tr").find("td:eq(2)").text();
                var empId=$(this).attr("del-id")
                //confirm会弹出确认框,点击确认值反值为true
                if(confirm("确认删除"+empName+"吗")) {

                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg)
                            to_page(currentPage)
                        }
                    })
                }

            })


            //全选/全不选

            $("#check_all").click(function () {

            $(".check_item").prop("checked",$(this).prop("checked"))


            })

            //
            $(document).on("click",".check_item",function () {
                //判断当前选择中的元素是否5个
                var flag=$(".check_item:checked").length==$(".check_item");
                $("#check_all").prop("check",flag)

            })

            //点击全部删除
            $("#emp_delete_all_btn").click(function () {
                var empNames=""
                var del_idstr=""
                $.each($(".check_item:checked"),function () {
                    //遍历选中 的check_item标签所在的行,拿到id和name
                    //并把所有的id  name放进empNames  del_strs
                    empNames +=$(this).parent("tr").find("td:eq(2)").text()+","
                    del_idstr+=$(this).parent("tr").find("td:eq(1)").text()+"-"

                })
                //去除empNames多余的,
                empNames=empNames.substring(0,empName.length-1)
                //去除删除的id多余的-
                del_idstr=del_idstr.substring(0,del_idstr.length-1)

                if (confirm("确认删除"+empNames+"吗")){
                    $.ajax({
                        url:"${APP_PATH}/emp/"+del_idstr,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg)
                            to_page(currentPages)
                        }
                    })
                }
            })
















        }








    </script>


</body>
</html>
