<%--
  Created by IntelliJ IDEA.
  User: zhaiwenhao
  Date: 15/6/25
  Time: 16:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

        <link href="<%=request.getContextPath()%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"
              rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css"
              type="text/css" rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/font-awesome/css/font-awesome.min.css" type="text/css"
              rel="stylesheet"/>

        <style type="text/css">
            #addForm label.error {
                color: red;
            }

            #addForm input.error {
                border-color: red;
            }
            .btn-group > .btn.active {
                border:1px solid white;
            }
        </style>
    </head>

    <body>
        <!-- top 菜单 begin -->
        <jsp:include page="/WEB-INF/views/base/top.jsp"/>
        <!-- top 菜单 end -->

        <div class="container">
            <div id="drawingboard_div" class="row row-offcanvas row-offcanvas-right" style="width:100%; height: 1000px; background-color: #EAEAEA; position: relative;">
                <canvas id='canvas_div' height="1000px"></canvas>
                <c:forEach items="${nodeInfoList}" var="node" varStatus="s">
                <div id='node_${node.nodeId}' name='node_button' style='position: absolute; top: ${node.yLocation}px; left: ${node.xLocation}px; cursor: pointer'>
                    <!-- 这个div用于右键菜单 -->
                    <div class="contextMenu">
                        <!-- 生成node，逐个判断属性 -->
                        <a href='javascript:;' class='btn btn-block ${node.nodeColor}' role='button' data-container='body'
                            <c:if test="${node.instruction != null && node.instruction != ''}">
                                data-toggle='popover' data-placement='top' data-html="true" data-content='${node.instruction}'
                            </c:if>
                            <c:if test="${node.linkUrl != null && node.linkUrl != ''}">
                                ondblclick='javascript:window.open("${node.linkUrl}");'
                            </c:if>
                        >
                            <!-- node内显示内容判断属性 -->
                            <input type='hidden' id='parent_${node.nodeId}' value='${node.parentNodeId}' />
                            <c:if test="${node.icon != null && node.icon != ''}">
                                <i class="fa ${node.icon}"></i>
                            </c:if>
                            ${node.nodeContent}
                            <c:if test="${node.instruction != null && node.instruction != ''}">
                                <i class="fa fa-font text-success"></i>
                            </c:if>
                            <c:if test="${node.linkUrl != null && node.linkUrl != ''}">
                                <i class="fa fa-link text-primary"></i>
                            </c:if>
                        </a>
                    </div>
                </div>
                </c:forEach>
            </div>

            <div id="context-menu">
                <ul class="dropdown-menu" role="menu">
                    <li><a tabindex="-1">编辑</a></li>
                    <li><a tabindex="-1">增加子项</a></li>
                    <li class="divider"></li>
                    <li><a tabindex="-1">删除</a></li>
                </ul>
            </div>

            <div id="modal_confirm_del_node" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-body">
                            <input type="hidden" id="input_del_node_id"/>
                            <div class="row">
                                <div class="col-xs-12">
                                您确定要删除此节点吗？一旦删除，其所有的子节点都将一起删除！
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


            <div id="modal_add_node" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <%--<div class="modal-header">--%>
                            <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                            <%--<h4 class="modal-title" id="gridSystemModalLabel">a</h4>--%>
                        <%--</div>--%>
                        <div class="modal-body">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <form id="addForm" class="form-signup">
                                <input type="hidden" id="input_idea_id" name="ideaId" value="${ideaInfo.ideaId}"/>
                                <input type="hidden" id="input_parent_id" name="parentId" />
                                <div class="form-group">
                                    <label for="input_node_content">内容</label>
                                    <input type="text" class="form-control" id="input_node_content" name="nodeContent" placeholder="内容" required/>
                                </div>
                                <div class="form-group">
                                    <label for="input_instruction">描述</label>
                                    <input type="text" class="form-control" id="input_instruction" name="instruction" placeholder="描述"/>
                                </div>
                                <div class="form-group">
                                    <label for="input_link_url">链接</label>
                                    <input type="text" class="form-control" id="input_link_url" name="linkUrl" placeholder="链接"/>
                                </div>
                                <div class="form-group">
                                    <label for="input_node_color">颜色</label>
                                    <br/>
                                    <div class="btn-group" data-toggle="buttons" id="input_node_color">
                                        <label class="btn btn-default active">
                                            <input type="radio" name="nodeColor" id="nodeColor_option1" value="btn-default" autocomplete="off" checked> &nbsp;
                                        </label>
                                        <label class="btn btn-primary">
                                            <input type="radio" name="nodeColor" id="nodeColor_option2" value="btn-primary" autocomplete="off"> &nbsp;
                                        </label>
                                        <label class="btn btn-success">
                                            <input type="radio" name="nodeColor" id="nodeColor_option3" value="btn-success" autocomplete="off"> &nbsp;
                                        </label>
                                        <label class="btn btn-info">
                                            <input type="radio" name="nodeColor" id="nodeColor_option4" value="btn-info" autocomplete="off"> &nbsp;
                                        </label>
                                        <label class="btn btn-warning">
                                            <input type="radio" name="nodeColor" id="nodeColor_option5" value="btn-warning" autocomplete="off"> &nbsp;
                                        </label>
                                        <label class="btn btn-danger">
                                            <input type="radio" name="nodeColor" id="nodeColor_option6" value="btn-danger" autocomplete="off"> &nbsp;
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="input_icon">图标</label>
                                    <br/>
                                    <div class="btn-group" data-toggle="buttons" id="input_icon">
                                        <label class="btn btn-default active" style="border-radius: 0px;">
                                            <input type="radio" name="icon" id="icon_option1" value="" autocomplete="off" checked>
                                            &nbsp;&nbsp;
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option2" value="fa-smile-o" autocomplete="off">
                                            <i class="fa fa-smile-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option3" value="fa-frown-o" autocomplete="off">
                                            <i class="fa fa-frown-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option4" value="fa-meh-o" autocomplete="off">
                                            <i class="fa fa-meh-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option7" value="fa-star" autocomplete="off">
                                            <i class="fa fa-star"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option5" value="fa-thumbs-o-up" autocomplete="off">
                                            <i class="fa fa-thumbs-o-up"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option6" value="fa-thumbs-o-down" autocomplete="off">
                                            <i class="fa fa-thumbs-o-down"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option8" value="fa-check-circle-o" autocomplete="off">
                                            <i class="fa fa-check-circle-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option9" value="fa-times-circle-o" autocomplete="off">
                                            <i class="fa fa-times-circle-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option10" value="fa-flag-o" autocomplete="off">
                                            <i class="fa fa-flag-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option11" value="fa-map-marker" autocomplete="off">
                                            <i class="fa fa-map-marker"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option12" value="fa-lightbulb-o" autocomplete="off">
                                            <i class="fa fa-lightbulb-o"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option13" value="fa-lock" autocomplete="off">
                                            <i class="fa fa-lock"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option14" value="fa-cloud" autocomplete="off">
                                            <i class="fa fa-cloud"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option15" value="fa-pencil" autocomplete="off">
                                            <i class="fa fa-pencil"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option16" value="fa-car" autocomplete="off">
                                            <i class="fa fa-car"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option17" value="fa-weixin" autocomplete="off">
                                            <i class="fa fa-weixin"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option18" value="fa-weibo" autocomplete="off">
                                            <i class="fa fa-weibo"></i>
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="icon" id="icon_option19" value="fa-qq" autocomplete="off">
                                            <i class="fa fa-qq"></i>
                                        </label>
                                        <label class="btn btn-default"  style="border-radius: 0px;">
                                            <input type="radio" name="icon" id="icon_option20" value="fa-qrcode" autocomplete="off">
                                            <i class="fa fa-qrcode"></i>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2"></div>
                                        <div class="col-xs-4">
                                            <button class="btn btn-success btn-block" type="button" onclick="doAddNode()">
                                                <i class="fa fa-save"></i>&nbsp;&nbsp;确 定
                                            </button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button class="btn btn-warning btn-block" type="button" onclick="doRest()">
                                                <i class="fa fa-reply"></i>&nbsp;&nbsp;重 置
                                            </button>
                                        </div>
                                        <div class="col-xs-2"></div>
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
    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap-contextmenu/bootstrap-contextmenu.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/additional-methods.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/localization/messages_zh.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/js/jquery.lazyload.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var canvas;
        var context;

        $(document).ready(function () {
            getCanvas();

            canvas.width = $("#drawingboard_div").css("width").split("px")[0];

            // 画出连接线
            drawAllLine();

            $('[data-toggle="popover"]').popover();

            // 每个node设置都可以拖动
            <c:if test="${null != sessionScope.user && sessionScope.user.userId == ideaInfo.userId && fn:length(nodeInfoList) >= 0}">
            // 右键菜单
            $(".contextMenu").contextmenu({
                target:'#context-menu',
                before: function(e,context) {
                    // execute code before context menu if shown
                },
                onItem: function(context,e) {
                    if ($(e.target).text() == "编辑") {
                        doEditNodeInit($(context).parent().attr("id").split("_")[1]);
                    } else if ($(e.target).text() == "增加子项") {
                        doAddNodeInit($(context).parent().attr("id").split("_")[1]);
                    } else if ($(e.target).text() == "删除") {
                        doDeleteInit($(context).parent().attr("id").split("_")[1]);
                    }
                }
            });

            $("div[name='node_button']").draggable({
                containment: "parent",
                stop: function( event, ui) {
                    doUpdateLocation($(this).attr("id").split("_")[1], ui.position.left, ui.position.top);
                },
                drag: function( event, ui ) {
                    drawAllLine();
                },
                start: function( event, ui) {
                    $(this).find('[data-toggle="popover"]').popover("hide");
                }
            });
            </c:if>

            $("#addForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });

            <c:if test="${null != sessionScope.user && sessionScope.user.userId == ideaInfo.userId && fn:length(nodeInfoList) == 0}">
            $("#modal_add_node").modal({backdrop: "static", show: true});
            </c:if>
        });

        function getCanvas() {
            canvas = document.getElementById("canvas_div");
            if (canvas == null) {
                return false;
            }
            context = canvas.getContext("2d");
        }

        function doAddNodeInit(nodeId) {
            $("#addForm")[0].reset();

            $("#input_parent_id").val(nodeId);

            $("#modal_add_node").modal({backdrop: "static", show: true});
        }

        function doAddNode() {
            if (!$("#addForm").valid()) {
                return;
            }

            var xLocation = 0;
            var yLocation = 0;

            var parentId =  $("#input_parent_id").val();

            if (parentId == null || parentId == "") {
                parentId = 0;
            }

            if (parentId == 0) {
                xLocation = eval(canvas.width / 2);
                yLocation = eval(canvas.height / 2);
            } else {
                var x = $("#node_" + parentId).css("left").replace("px", "")
                var y = $("#node_" + parentId).css("top").replace("px", "")

                if (y >= 500) {
                    yLocation = eval($("#node_" + parentId).css("top").replace("px", "")) + eval(100);
                } else {
                    yLocation = eval($("#node_" + parentId).css("top").replace("px", "") - 100);
                }

                if (x >= eval(canvas.width / 2)) {
                    xLocation = eval($("#node_" + parentId).css("left").replace("px", "")) + eval(100);
                } else {
                    xLocation = eval($("#node_" + parentId).css("left").replace("px", "") - 100);
                }
            }

            $.ajax({
                url: "<%=request.getContextPath() %>/idea_node/add.json",  //这里是网址
                type: "POST",
                data:{
                    ideaId : $("#input_idea_id").val(),
                    nodeContent : $("#input_node_content").val(),
                    parentId : parentId,
                    instruction : $("#input_instruction").val(),
                    linkUrl : $("#input_link_url").val(),
                    nodeColor :  $("input[name='nodeColor']:checked").val(),
                    icon :  $("input[name='icon']:checked").val(),
                    xLocation : xLocation,
                    yLocation : yLocation
                },
                dataType: "json",
                async: true,
                success:function(data){
                    if (data == null) {
                    } else {
                        var str = "";
                        str += "<div id='node_"+data.nodeId+"' name='node_button' style='position: absolute; top: "+data.yLocation+"px; left: "+data.xLocation+"px; cursor: pointer'>";
                        str += "<div class='contextMenu'>";
                        str += "<a href='javascript:;' class='btn "+data.nodeColor+" btn-block' ondblclick='javascript:window.open("+data.linkUrl+");' role='button'";
                        if (data.instruction != null && data.instruction != "") {
                            str += "data-toggle='popover' data-placement='top' data-html='true' data-content='"+data.instruction+"'>";
                        } else {
                            str += ">";
                        }
                        str += "<input type='hidden' id='parent_"+data.nodeId+"' value='"+data.parentNodeId+"' />";
                        if (data.icon != null && data.icon != "") {
                            str += "<i class='fa " + data.icon + "'></i> ";
                        }
                        str += data.nodeContent;
                        if (data.instruction != null && data.instruction != "") {
                            str += " <i class='fa fa-font text-success'></i>";
                        }
                        if (data.linkUrl != null && data.linkUrl != "") {
                            str += " <i class='fa fa-link text-primary'></i>";
                        }
                        str += "</a>";
                        str += "</div>"
                        str += "</div>";

                        $("#drawingboard_div").append(str);

                        $('#node_'+data.nodeId).draggable({
                            containment: "parent",
                            stop: function( event, ui) {
                                doUpdateLocation($(this).attr("id").split("_")[1], ui.position.left, ui.position.top);
                            },
                            drag: function( event, ui ) {
                                drawAllLine();
                            }
                        });

                        drawAllLine();

                        $('#node_' + data.nodeId).find('[data-toggle="popover"]').popover();

                        $('#node_' + data.nodeId).find(".contextMenu").contextmenu({
                            target:'#context-menu',
                            before: function(e,context) {
                                // execute code before context menu if shown
                            },
                            onItem: function(context,e) {
                                if ($(e.target).text() == "编辑") {
                                    doEditNodeInit($(context).parent().attr("id").split("_")[1]);
                                } else if ($(e.target).text() == "增加子项") {
                                    doAddNodeInit($(context).parent().attr("id").split("_")[1]);
                                } else if ($(e.target).text() == "删除") {
                                    doDeleteInit($(context).parent().attr("id").split("_")[1]);
                                }
                            }
                        });

                        $("#modal_add_node").modal("hide");
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function drawAllLine() {
            // 清除画板上所有东西
            context.clearRect(0, 0, canvas.width, canvas.height);

            $("div[name='node_button']").each(function(index, item){
                var id = $(item).attr("id");

                var parentId = $("#parent_" + id.split("_")[1]).val();

                if (parentId == 0 || parentId == "0") {
//                    continue;
                } else {
                    var parentNode = $("#node_"+parentId);

                    drawSingleLine($(parentNode), $(item));
                }
            });
        }

        function drawSingleLine(startObj, endObj) {
            var startX = eval($(startObj).css("left").split("px")[0]) + eval($(startObj).css("width").split("px")[0] / 2);
            var startY = eval($(startObj).css("top").split("px")[0]) + eval($(startObj).css("height").split("px")[0] / 2);
            var endX = eval($(endObj).css("left").split("px")[0]) + eval($(endObj).css("width").split("px")[0] / 2);
            var endY = eval($(endObj).css("top").split("px")[0]) + eval($(endObj).css("height").split("px")[0] / 2);

            context.strokeStyle = "rgb(250,0,0)";
            context.fillStyle = "rgb(250,0,0)";

            context.beginPath();
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);
            context.stroke();
        }

        function doUpdateLocation(nodeId, xLocation, yLocation) {
            $.ajax({
                url: "<%=request.getContextPath() %>/idea_node/update_location.json",  //这里是网址
                type: "POST",
                data:{
                    nodeId : nodeId,
                    xLocation : xLocation,
                    yLocation : yLocation
                },
                dataType: "json",
                async: true,
                success:function(data){

                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function doRest() {
            $("#addForm")[0].reset();
        }

        function doDeleteInit(nodeId) {
            $("#input_del_node_id").val(nodeId);
            $("#modal_confirm_del_node").modal({backdrop: "static", show: true});
        }

        function doCancel() {
            $("#input_del_node_id").val("");
            $("#modal_confirm_del_node").modal("hide");
        }

        function doDelete() {
            var nodeId = $("#input_del_node_id").val();

            $.ajax({
                url: "<%=request.getContextPath() %>/idea_node/delete.json",  //这里是网址
                type: "POST",
                data:{
                    nodeId : nodeId
                },
                dataType: "json",
                async: true,
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