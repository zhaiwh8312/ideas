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
        <link href="<%=request.getContextPath()%>/resource/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet"/>

        <style type="text/css">
            #addForm label.error {
                color: red;
            }

            #addForm input.error {
                border-color: red;
            }
        </style>
    </head>

    <body>
    <!-- top 菜单 begin -->
    <jsp:include page="/WEB-INF/views/base/top.jsp"/>
    <!-- top 菜单 end -->

    <div class="container">

        <div class="row row-offcanvas row-offcanvas-right">

            <div class="col-xs-12 col-sm-12">
                <%--<p class="pull-right visible-xs">--%>
                    <%--<button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>--%>
                <%--</p>--%>
                <div class="row" style="text-align: center;">
                    <c:forEach items="${ideaInfoList}" var="ideaInfo" varStatus="s">
                        <div class="col-xs-6 col-lg-4" style="padding-top: 20px">
                            <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140">

                            <h2>${ideaInfo.ideaName}</h2>

                            <p>
                                <c:choose>
                                    <c:when test="${ideaInfo.isPublic == true}">
                                        公开
                                    </c:when>
                                    <c:otherwise>
                                        私人
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <p><a class="btn btn-default" href="#" role="button">查看详情 &raquo;</a></p>
                        </div>
                        <!--/.col-xs-6.col-lg-4-->
                    </c:forEach>

                    <div class="col-xs-6 col-lg-4" style="padding-top: 20px">
                        <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140"
                                onclick="doAddInit()"/>

                        <h2>创建一个idea</h2>

                        <p>留下你转瞬即逝的好点子</p>

                        <p><a class="btn btn-default" href="javascript:;" role="button" onclick="doAddInit()">创建idea &raquo;</a></p>

                    </div>
                    <!--/.col-xs-6.col-lg-4-->
                </div>
                <!--/row-->
            </div>
            <!--/.col-xs-12.col-sm-9-->
        </div>
        <!--/row-->

        <div id="modal_add_idea" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="gridSystemModalLabel">创建我的idea</h4>
                    </div>
                    <div class="modal-body">
                        <form id="addForm" class="form-signup">
                            <div class="form-group">
                                <label for="input_idea_name">标题</label>
                                <input type="text" class="form-control" id="input_idea_name" name="ideaName" placeholder="标题" required/>
                            </div>
                            <div class="form-group">
                                <input type="checkbox" id="input_isPublic" name="isPublic" checked data-on-text="公开" data-off-text="私人" data-on-color="primary" data-off-color="danger"/>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <button class="btn btn-success btn-block" type="button" onclick="doAddIdea()">
                                            <i class="fa fa-save"></i>&nbsp;&nbsp;确 定
                                        </button>
                                    </div>
                                    <div class="col-xs-6">
                                        <button class="btn btn-warning btn-block" type="button" onclick="doRest()">
                                            <i class="fa fa-reply"></i>&nbsp;&nbsp;重 置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/base/foot.jsp"/>
    </div>
    <!--/.container-->
    </body>

    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/additional-methods.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/localization/messages_zh.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("[name='isPublic']").bootstrapSwitch();

            $("#addForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });

//            $("[name='isPublic']").on('switchChange.bootstrapSwitch', function(event, state) {
//                console.log(this); // DOM element
//                console.log(event); // jQuery event
//                console.log(state); // true | false
//            });
        });

        function doRest() {
            $("#addForm")[0].reset();
        }

        function doAddInit() {
            $("#addForm")[0].reset();

            $("#modal_add_idea").modal("show");
        }

        function doAddIdea() {
            if (!$("#addForm").valid()) {
                return;
            }

            $.ajax({
                url: "<%=request.getContextPath() %>/ideas/add.json",  //这里是网址
                type: "POST",
                data:{
                    ideaName : $("#input_idea_name").val(),
                    ideaPicUrl : "",
                    isPublic : $("[name='isPublic']").bootstrapSwitch('state')
                },
                dataType: "json",
                async: false,
                success:function(data){
                    if (data == -1) {
//                        $(".modal-content").html("注册成功！");
//
//                        $("#modal_msg").modal("show");
                    } else {
                        // 新增成功
                        window.location.reload();
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

    </script>
</html>