<%--
  Created by IntelliJ IDEA.
  User: zhaiwenhao
  Date: 15/6/25
  Time: 16:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>ideas</title>
        <!-- Set render engine for 360 browser -->
        <meta name="renderer" content="webkit">
        <!-- No Baidu Siteapp -->
        <meta http-equiv="Cache-Control" content="no-siteapp">
        <!-- Add to homescreen for Chrome on Android -->
        <meta name="mobile-web-app-capable" content="yes">

        <link href="<%=request.getContextPath()%>/resource/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet"/>

        <style type="text/css">
            #signupForm label.error {
                color: red;
            }
            #signupForm input.error {
                border-color: red;
            }
        </style>
    </head>

    <body>
        <!-- top 菜单 begin -->
        <jsp:include page="/WEB-INF/views/base/top.jsp" />
        <!-- top 菜单 end -->

        <div class="container">

            <div class="row row-offcanvas row-offcanvas-right">

                <div class="col-xs-12 col-sm-9">
                    <div class="jumbotron">
                        <h1>Hello, ideas!</h1>

                        <p>This is an example to show the potential of an offcanvas layout pattern in Bootstrap. Try some
                            responsive-range viewport sizes to see it in action.</p>
                    </div>
                    <div id="ideas_div" class="row" style="text-align: center;">

                    </div>
                    <!--/row-->
                </div>
                <!--/.col-xs-12.col-sm-9-->

                <c:choose>
                    <c:when test="${null != sessionScope.user}">
                        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
                            ${sessionScope.user.email}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 登录注册框 begin -->
                        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
                            <form id="signupForm" class="form-signup">
                                <div class="form-group">
                                    <div id="test_div1"></div>
                                    <div id="test_div2"></div>
                                    <label for="input_email">邮箱地址</label>
                                    <input type="email" class="form-control" id="input_email" placeholder="邮箱地址" required checkUnique="true"/>
                                </div>
                                <div class="form-group">
                                    <label for="input_password">您的密码</label>
                                    <input type="password" class="form-control" id="input_password" placeholder="您的密码" required/>
                                </div>
                                <div class="form-group">
                                    <label for="input_confirm_password">确认密码</label>
                                    <input type="password" class="form-control" id="input_confirm_password" placeholder="确认密码" required equalTo="#input_password"/>
                                </div>
                                <button class="btn btn-lg btn-success btn-block" type="button" onclick="doRegist()">注 册</button>
                            </form>
                        </div>
                        <!-- 登录注册框 end -->
                    </c:otherwise>
                </c:choose>
                <!--/.sidebar-offcanvas-->
            </div>
            <!--/row-->

            <jsp:include page="/WEB-INF/views/base/foot.jsp" />

            <div id="modal_msg" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="gridSystemModalLabel">IDEAS</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-content">
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!--/.container-->
    </body>

    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/additional-methods.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/localization/messages_zh.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/js/jquery.lazyload.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            initIdeasList();

            $("#signupForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });

            $.validator.addMethod("checkUnique", function(value, element) {
                var flag = false;

                $.ajax({
                    url: "<%=request.getContextPath() %>/user/checkEmailUnique.json",  //这里是网址
                    type: "POST",
                    data:{
                        email : value
                    },
                    dataType: "json",
                    async: false,
                    success:function(data){
                        flag = data;
                    },
                    timeout:30000,
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        flag = false;
                    }
                });

                return flag;
            }, "此邮箱已被使用");

            $.validator.addMethod("equalTo", function(value, element, param) {
                var target = $( param );

                if ( this.settings.onfocusout ) {
                    target.unbind( ".validate-equalTo" ).bind( "blur.validate-equalTo", function() {
                        $( element ).valid();
                    });
                }

                return value === target.val();
            }, "您的密码与确认密码不相同");
        });

        function doRegist() {
            if (!$("#signupForm").valid()) {
                return;
            }

            $.ajax({
                url: "<%=request.getContextPath() %>/user/regist.json",  //这里是网址
                type: "POST",
                data:{
                    email : $("#input_email").val(),
                    password : $("#input_password").val()
                },
                dataType: "json",
                async: false,
                success:function(data){
                    if (data) {
                        $(".modal-content").html("注册成功！");

                        $("#modal_msg").modal("show");
                    } else {
                        $(".modal-content").html("注册失败！");

                        $("#modal_msg").modal("show");
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function initIdeasList() {
            $.ajax({
                url: "<%=request.getContextPath() %>/idea/public_list.json",  //这里是网址
                type: "POST",
                data:{
                    offset : 0,
                    limit : 10
                },
                dataType: "json",
                async: true,
                success:function(data){
                    var str = "";

                    for(var i = 0; i < data.length; i++){
                        var idea = data[i];

                        str += '<div class="col-xs-6 col-lg-4" style="padding-top: 20px">';
                        if (idea.ideaPicUrl == "" || idea.ideaPicUrl == null) {
                            str += '<p><img class="img-circle" src="<%=request.getContextPath()%>/resource/images/ideas.jpg" alt="" title="点击进入" width="140" height="140" style="cursor: pointer" onclick="javascript:window.location.href=\'<%=request.getContextPath()%>/idea/'+idea.ideaId+'.html\'" ></p>';
                        } else {
                            str += '<p><img class="img-circle" src="'+idea.ideaPicUrl+'" alt="" title="点击进入" width="140" height="140" style="cursor: pointer" onclick="javascript:window.location.href=\'<%=request.getContextPath()%>/idea/'+idea.ideaId+'.html\'"></p>';
                        }
                        str += '<h2 class="text-primary">'+idea.ideaName+'</h2>';
                        str += '<p class="text-primary">公开</p>';
//                        str += '<p>共50个节点</p>';
                        str += '</div>';
                    }

                    $("#ideas_div").html(str);

                    $("img.img-circle").lazyload();
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }
    </script>
</html>