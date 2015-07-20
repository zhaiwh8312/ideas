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
                <div class="row" style="text-align: center;">
                    <c:forEach items="${ideaInfoList}" var="ideaInfo" varStatus="s">
                        <div class="col-xs-6 col-lg-4" style="padding-top: 20px">
                            <c:choose>
                                <c:when test="${ideaInfo.ideaPicUrl == '' || null == ideaInfo.ideaPicUrl}">
                                    <img class="img-circle" src="<%=request.getContextPath()%>/resource/images/ideas.jpg"
                                         alt="" title="点击进入" width="140" height="140" style="cursor: pointer" onclick="javascript:window.location.href='<%=request.getContextPath()%>/idea/${ideaInfo.ideaId}.html'">
                                </c:when>
                                <c:otherwise>
                                    <img class="img-circle" src="${ideaInfo.ideaPicUrl}"
                                         alt="" title="点击进入" width="140" height="140" style="cursor: pointer" onclick="javascript:window.location.href='<%=request.getContextPath()%>/idea/${ideaInfo.ideaId}.html'">
                                </c:otherwise>
                            </c:choose>

                            <h2 class="text-primary">${ideaInfo.ideaName}</h2>

                            <c:choose>
                                <c:when test="${ideaInfo.isPublic == true}">
                                    <p class="text-primary">公开</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-danger">私人</p>
                                </c:otherwise>
                            </c:choose>

                            <%--<p>共50个节点</p>--%>

                            <p>
                                <div class="row">
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-info" title="编辑" onclick="doUpdateInit(${ideaInfo.ideaId})">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger" title="删除" onclick="doDeleteInit(${ideaInfo.ideaId})">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                    <%--<div class="col-xs-3">--%>
                                        <%--<button class="btn btn-success btn-block" type="button">--%>
                                            <%--<i class="fa fa-pencil"></i>--%>
                                        <%--</button>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-3">--%>
                                        <%--<button class="btn btn-warning btn-block" type="button" onclick="doRest()">--%>
                                            <%--<i class="fa fa-reply"></i>&nbsp;&nbsp;重 置--%>
                                        <%--</button>--%>
                                    <%--</div>--%>
                                </div>
                            </p>

                        </div>
                        <!--/.col-xs-6.col-lg-4-->
                    </c:forEach>

                    <div class="col-xs-6 col-lg-4" style="padding-top: 20px">
                        <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="" title="点击进入" width="140" height="140" style="cursor: pointer"
                                onclick="doAddInit()"/>

                        <h2 class="text-info">创建一个idea</h2>

                        <p class="text-success">create</p>

                        <p><a class="btn btn-default" href="javascript:;" role="button" onclick="doAddInit()">创建idea &raquo;</a></p>

                    </div>
                    <!--/.col-xs-6.col-lg-4-->
                </div>
                <!--/row-->
            </div>
            <!--/.col-xs-12.col-sm-9-->
        </div>
        <!--/row-->

        <div id="modal_confirm_del_idea" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-body">
                        <input type="hidden" id="input_del_idea_id" name="input_del_idea_id"/>
                        <div class="row">
                            <div class="col-xs-12">
                            您确定要删除这个idea吗？
                            </div>
                        </div>
                        <p></p>
                        <div class="row">
                            <div class="col-xs-6">
                                <button class="btn btn-primary btn-block" type="button" onclick="doDelete()">
                                    <i class="fa fa-check"></i>&nbsp;&nbsp;确 定
                                </button>
                            </div>
                            <div class="col-xs-6">
                                <button class="btn btn-default btn-block" type="button" onclick="doCancel()">
                                    <i class="fa fa-ban"></i>&nbsp;&nbsp;取 消
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="modal_operat_idea" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="gridSystemModalLabel">创建我的idea</h4>
                    </div>
                    <div class="modal-body">
                        <form id="addForm" class="form-signup">
                            <input type="hidden" id="input_idea_id" name="input_idea_id" />
                            <div class="form-group">
                                <label for="input_idea_name">标题</label>
                                <input type="text" class="form-control" id="input_idea_name" name="ideaName" placeholder="标题" required/>
                            </div>
                            <div class="form-group">
                                <input type="checkbox" id="input_isPublic" name="isPublic" checked data-on-text="公开" data-off-text="私人" data-on-color="primary" data-off-color="danger"/>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-3"></div>
                                    <div class="col-xs-6">
                                        <button class="btn btn-success btn-block" type="button" onclick="doOperate()">
                                            <i class="fa fa-save"></i>&nbsp;&nbsp;确 定
                                        </button>
                                    </div>
                                    <div class="col-xs-3"></div>
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
    <script src="<%=request.getContextPath()%>/resource/js/jquery.lazyload.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("img.img-circle").lazyload();

            $("[name='isPublic']").bootstrapSwitch();

            $("#addForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });
        });

        function doRest() {
            $("#addForm")[0].reset();
        }

        function doAddInit() {
            $("#addForm")[0].reset();

            $("#gridSystemModalLabel").html("创建我的idea");

            $("#modal_operat_idea").modal({backdrop: "static", show: true});
        }

        function doAddIdea() {
            if (!$("#addForm").valid()) {
                return;
            }

            $("#input_idea_id").val("");

            $.ajax({
                url: "<%=request.getContextPath() %>/idea/add.json",  //这里是网址
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
                        // 新增失败
                    } else {
                        // 新增成功
                        window.location.href = "<%=request.getContextPath()%>/idea/"+data+".html";
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function doUpdateInit(ideaId) {
            $("#gridSystemModalLabel").html("修改我的idea");

            $.ajax({
                url: "<%=request.getContextPath() %>/idea/info/"+ideaId+".json",  //这里是网址
                type: "POST",
                data:{
                },
                dataType: "json",
                async: false,
                success:function(data){
                    if (data == null) {
                        // 获取失败
                    } else {
                        $("#input_idea_id").val(data.ideaId);
                        $("#input_idea_name").val(data.ideaName);

                        $("[name='isPublic']").bootstrapSwitch("state", data.isPublic);

                        $("#modal_operat_idea").modal({backdrop: "static", show: true});
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function doUpdate() {
            $.ajax({
                url: "<%=request.getContextPath() %>/idea/update.json",  //这里是网址
                type: "POST",
                data:{
                    ideaId : $("#input_idea_id").val(),
                    ideaName : $("#input_idea_name").val(),
                    isPublic : $("[name='isPublic']").bootstrapSwitch('state')
                },
                dataType: "json",
                async: false,
                success:function(data){
                    if (data == null) {
                        // 更新失败
                    } else {
                        // 更新成功
                        window.location.reload();
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function doOperate() {
            if ($("#gridSystemModalLabel").html() == "创建我的idea") {
                doAddIdea();
            } else {
                doUpdate();
            }
        }

        function doDeleteInit(ideaId) {
            $("#input_del_idea_id").val(ideaId);
            $("#modal_confirm_del_idea").modal({backdrop: "static", show: true});
        }

        function doCancel() {
            $("#input_del_idea_id").val("");
            $("#modal_confirm_del_idea").modal("hide");
        }

        function doDelete() {
            var ideaId = $("#input_del_idea_id").val();

            $.ajax({
                url: "<%=request.getContextPath() %>/idea/delete.json",  //这里是网址
                type: "POST",
                data:{
                    ideaId : ideaId
                },
                dataType: "json",
                async: false,
                success:function(data){
                    if (data != null) {
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