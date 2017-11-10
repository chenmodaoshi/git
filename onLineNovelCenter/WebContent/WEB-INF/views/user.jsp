<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
		
		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
		
		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrapValidator.css" />
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrapValidator.js" ></script>

		<link rel="stylesheet" type="text/css" href="css//style_46_common.css">
		<link rel="stylesheet" type="text/css" href="css//style_46_forum_forumdisplay.css">

		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/fileinput.css" />
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/fileinput.js" ></script>
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/zh.js" ></script>

		<script src="js/hm.js" type="text/javascript"></script>
		<script src="js/forum.js" type="text/javascript"></script>
		<script type="text/javascript" charset="UTF-8" src="js/common_extra.js"></script>
		
		<!--
        	作者：763265137@qq.com
        	时间：2017-07-29
        	描述：验证
        -->
		<script src="js/bootstrapValidator.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="css/bootstrapValidator.css"/>
	</head>
	<style>
		/* Custom Styles */
		
		ul.nav-tabs {
			width: 140px;
			margin-top: 20px;
			border-radius: 4px;
			border: 1px solid #ddd;
			box-shadow: 0 1px 4px;
		}
		
		ul.nav-tabs li {
			margin: 0;
			border-top: 1px solid #ddd;
		}
		
		ul.nav-tabs li:first-child {
			border-top: none;
		}
		
		ul.nav-tabs li a {
			margin: 0;
			padding: 8px 16px;
			border-radius: 0;
		}
		
		ul.nav-tabs li.active a,
		ul.nav-tabs li.active a:hover {
			color: #fff;
			background: #0088cc;
			border: 1px solid #0088cc;
		}
		
		ul.nav-tabs li:first-child a {
			border-radius: 4px 4px 0 0;
		}
		
		ul.nav-tabs li:last-child a {
			border-radius: 0 0 4px 4px;
		}
		
		ul.nav-tabs.affix {
			top: 30px;
			/* Set the top position of pinned element */
		}
	</style>
	<script>
	  
		$(document).ready(function() {
			$("#myNav").affix({
				offset: {
					top: 125
				}
			});
		});
		function logout(){
			$.ajax({
				url : 'logoutUser',
				type : 'post',
				dataType: "text",
				success : function(data){
					if(data=='success'){
						location.href = 'index.jsp';
					}else{
						alert("注销失败");
					}
				}
			}); /*onregister-ajax*/
		}
		
			
	</script>

	<body style="background: url(img/22.jpg) no-repeat fixed 50% 0;background-size: 100% 100%;">

		<div style="width: 71.3%;margin: 0 auto;">
			<!--头部＋导航＋搜索
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：头部＋导航＋搜索
            -->
			<div class="t9_top" style="width: 920px;">
				<div id="hd">
					<div class="wp">
						<!--注册/登录
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：欢迎注册/登录
           -->
						<div class="hdc cl">
							<h2><a href="index.jsp" title="萌动动漫论坛"><img src="img/logo.png" alt="萌动动漫论坛" border="0"></a></h2>
							<div class="fastlg cl">
								<div class="y pns">
									<table cellspacing="0" cellpadding="0">
										<tbody>
											<tr>
												<c:if test="${!empty sessionScope.user}">
													欢迎！<a href="myuser" style="font-size:18px;">${sessionScope.user.petname}</a>&nbsp;&nbsp;|
													<button type="button" class="btn btn-primary" onclick="logout();">
													注销
													</button>
												</c:if>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!--导航栏
                    	作者：763265137@qq.com
                    	时间：2017-07-27
                    	描述：导航栏
                    -->
						<div id="nv">
							<a href="javascript:;" id="qmenu" onmouseover="delayShow(this, function () {showMenu({'ctrlid':'qmenu','pos':'34!','ctrlclass':'a','duration':2});showForummenu(45);})" initialized="true" class="">快捷导航</a>
							<ul>
								<li id="mn_forum"><a href="index.jsp" hidefocus="true">萌首页</a></li>
								<li id="mn_N1771"><a href="toSeachPostResultPage?searchType=请选择类型&keyword=" hidefocus="true">萌搜搜索</a></li>
								<c:if test="${sessionScope.user.pow!=2}">
									<li id="mn_Na033"><a href="backstage" hidefocus="true">后台管理</a></li>
								</c:if>
								<li id="mn_N7b38" class="a"><a href="#" hidefocus="true">个人信息</a></li>
								<li id="mn_N2d81"><a href="toSeachPostResultPage?searchType=动漫音乐&keyword=" hidefocus="true">动漫音乐</a></li>
								<li id="mn_N7b38"><a href="toSeachPostResultPage?searchType=游戏之声&keyword=" hidefocus="true">游戏之声</a></li>
								<li id="mn_Nbda6"><a href="toSeachPostResultPage?searchType=动画之家&keyword=" hidefocus="true">动画之家</a></li>
								<li id="mn_Na3de"><a href="toSeachPostResultPage?searchType=小说分享&keyword=" hidefocus="true">小说分享</a></li>
							</ul>
						</div>
						<!--搜索
                    	作者：763265137@qq.com
                    	时间：2017-07-27
                    	描述：搜索
                    -->
						<div class="p_pop h_pop" id="mn_userapp_menu" style="display: none"></div>
						<div id="scbar" class="cl">
							<form id="scbar_form" method="post" autocomplete="off" onsubmit="searchFocus($('scbar_txt'))" action="search.php?searchsubmit=yes" target="_blank">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="scbar_icon_td"></td>
										<td class="scbar_txt_td"><input name="srchtxt" id="scbar_txt" autocomplete="off" x-webkit-speech="" speech="" class=" xg1" placeholder="请输入搜索内容" type="text"></td>
										<td class="scbar_type_td"><a href="javascript:;" id="scbar_type" class="xg1" onclick="showMenu(this.id)" hidefocus="true">搜索</a></td>
										<td class="scbar_btn_td"><button type="submit" name="searchsubmit" id="scbar_btn" sc="1" class="pn pnc" value="true"><strong class="xi2">搜索</strong></button></td>
										<td class="scbar_hot_td">
											<div id="scbar_hot">
											</div>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>

			<br/>

			<body data-spy="scroll" data-target="#myScrollspy">
				<div class="container">

					<div class="row">
						<div class="col-xs-2" id="myScrollspy">
							<ul class="nav nav-tabs nav-stacked" id="myNav">
								<li class="active"><a href="myuser#section-1" onclick="active(this)">个人信息</a></li>
								<li><a href="myuser#section-2" onclick="active(this)">帖子列表</a></li>
								<li><a href="myuser#section-3" onclick="active(this)">评论列表</a></li>
								<li><a href="myuser#section-4" onclick="active(this)">修改密码</a></li>
							</ul>
						</div>
						<div class="col-xs-8">

							<div class="panel panel-danger" id="section-1" style="width: 750px;">

			<div class="panel-heading">
				<h3 class="panel-title">
				个人信息:
				<c:choose>
				    <c:when test="${sessionScope.user.pow==0}">
				       	超级管理员
				    </c:when>
				    <c:when test="${sessionScope.user.pow==1}">
				       	管理员
				    </c:when>
				    <c:otherwise>
				                    普通用户
				    </c:otherwise>
				</c:choose>
				</h3>
			</div>
			<div class="panel-body" style="height: auto;">
				<!-- 头像 -->
				<div>			
					<img src="${sessionScope.user.head}" style="width: 10%;margin-left: 20px;outline:#ffffff  solid 7px;outline-offset: 1px;" class="img-thumbnail img-circle" id="headIcon"/>
				</div>
				<!-- 上传头像模态框 -->
				<form>
				    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				        <div class="modal-dialog modal-lg" role="document">
				            <div class="modal-content">
				                <div class="modal-header">
				                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				                    <h4 class="modal-title" id="myModalLabel">请选择头像</h4>
				                </div>
				                <div class="modal-body">
				                    <input type="file" name="txt_file" id="txt_file" multiple class="file-loading" />
				                </div></div>
				        </div>
				    </div>
				</form>	
				
				<div style="width: 70%;margin: 0px auto;">
					<form id="userModify">
							<input type="hidden" name="userid" value="${sessionScope.user.userid}"/>
				            <div class="form-group">
				                <label>昵称</label>
				                <input type="text" class="form-control"  name="petname" value="${sessionScope.user.petname}"/>
				            </div>
				            <div class="form-group">
				                <label>性别</label>
				                <select class="form-control" name="sex" >
								  <option <c:if test='${sessionScope.user.sex=="男"}'> selected='selected' </c:if>>男</option>
								  <option <c:if test='${sessionScope.user.sex=="女"}'> selected='selected' </c:if>>女</option>
								</select>
				            </div>
				            <div class="form-group">
				                <label>注册时间</label>
				                <input type="text" class="form-control" readonly="readonly" value="${sessionScope.user.regdate}"/>
				            </div>
				            <div class="form-group">
				                <label>手机号码</label>
				                <input type="text" class="form-control" name="phone" value="${sessionScope.user.phone}"/>
				            </div>
				            <div class="form-group" style="text-align: center;">				            	
								<!-- 按钮触发模态框 -->
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
									更换头像
								</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-primary" id="savebtn" onclick="onsave();">
									保存修改
								</button>
							</div>
				        </form>
				</div>
			</div>

		</div>
		<script type="text/javascript">
			function loadPostByPage(pageNum) {
				var userid=${sessionScope.user.userid};
				$.ajax({
					type: "GET",
					url: "loadPostByUser?requestPageNum=" + pageNum+"&userid="+userid,
					success: function(data) {
						var tbody = "<tr><td style='width:20%'>帖子类型</td><td>标题</td><td style='width:20%'>回复/查看</td><td>发表时间</td></tr>";
						var ptypeHead = "<td><span class='glyphicon glyphicon-eye-open'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
						var ptypeTail = "</a></span></td>";
						var pnameHead = "<td><a href='goScondCommByPostId?postId=";
						var pnameTail = "</td>";
						var userHead = "<td><a href='javascript:void(0);'>";
						var userTail = "</a></td>";
						var commhead = "<td>";
						var commTail = "</td>";
						var lastDateHead = "<td>";
						var lastDateTail = "</td>";
						
						for (var i = 0; i < data[1].length; i++) {
							if(i<10)
							 tbody += ("<tr id='" + data[1][i].postid + "'>" + ptypeHead + data[1][i].ptype + ptypeTail +pnameHead +data[1][i].postid+"'>"+ data[1][i].pname+pnameTail + commhead + data[1][i].commnum + "/" + data[1][i].clicknum + commTail + lastDateHead + data[1][i].createdate + lastDateTail + "</tr>");
						}
						$("#postList").html(tbody);
						$("#pageNums").html("");
						pageCount = data[0]; //总页数
						// $("#pageNums")
						var $navHead = $("<li><a href='javascript:void(0);'>&laquo;</a></li>");
						$navHead.click(function() {
							var lis = $("#pageNums a").not(":first").not(
								":last");
							var num = parseInt($(lis[0]).text());
							if (num >= 2) {
								$(lis[0]).text(num - 1);
								$(lis[1]).text(num);
								$(lis[2]).text(num + 1);
								$(lis[3]).text(num + 2);
								$(lis[4]).text(num + 3);
							}
						})
						$("#pageNums").append($navHead);
						if (data[0] > 4 && pageNum >= data[0] - 4 && pageNum <= data[0]) {
							var n = data[0] - 4;
							for (var num = 0; num < 5; num++) {
								var $li = $("<li><a href='javascript:void(0);'>" + n + "</a></li>");
								//alert($li.children()[0].text)
								$("#pageNums").append($li);
								n = n + 1;
							}
						} else {
							if (data[0] <= 4) {
								pageNum = 1;
							}
							for (var num = 0; num < 5; num++) {
								if (pageNum + num <= pageCount) {
									var $li = $("<li><a href='javascript:void(0);'>" + (pageNum + num) + "</a></li>");
									//alert($li.children()[0].text)
									$("#pageNums").append($li);
								}
							}
						}
						var $navTail = $("<li><a href='javascript:void(0);'>&raquo;</a></li>");
						$navTail.click(function() {
							var lis = $("#pageNums a").not(":first").not(
								":last");
							var num = parseInt($(lis[1]).text());
							if (num < data[0] - 3) {
								$(lis[0]).text(num);
								$(lis[1]).text(num + 1);
								$(lis[2]).text(num + 2);
								$(lis[3]).text(num + 3);
								$(lis[4]).text(num + 4);
							}
						})
						$("#pageNums").append($navTail);
						$("#pageNums a").not(":first").not(":last").click(
							function() {
								var num = parseInt($(this).text());
								loadPostByPage(num);
							});
					},
					error: function(data) {
						$("#postList").html("請求失敗，請刷新頁面");
					}
				});
			//ajax 结束
			return false;
		}
			//评论列表8-1 begin
			function loadCommByPage(page) {
				var row = 10;
				var userid=${sessionScope.user.userid};
				$.ajax({
					type: "GET",
					url: "getCommByPage?row=" + row+"&page="+page+"&userid="+userid,
					success: function(data) {
						var tbody = "<tr><td>帖子名称</td><td>评论内容</td><td>发表时间</td></tr>";
					/* 	var commidHead = "<td>";
						var commidTail = "</td>"; */
						var pnameHead = "<td><a href='goScondCommByPostId?postId=";
						var pnameTail = "</a></td>";
						var contexthead = "<td>";
						var contextTail = "</td>";
						var lastDateHead = "<td>";
						var lastDateTail = "</td>";	
						for (var i = 0; i < data[1].length; i++) {//data[1][i].post==null?null:data[1][i].post.pname
							tbody += ("<tr id='" + data[1][i].post.postid + "'>"  + pnameHead +data[1][i].post.postid+"'>" +data[1][i].post.pname + pnameTail + contexthead + data[1][i].content + contextTail + lastDateHead +new Date(data[1][i].pubdate).Format('yyyy-MM-dd hh:mm：ss')  + lastDateTail + "</tr>");
						}
						$("#commList").html(tbody);
						
						
						$("#pageCommNums").html("");
				
						var pageCount = data[0];//总页数

						var $navHead = $("<li><a href='javascript:void(0);'>&laquo;</a></li>");
						$navHead.click(function() {
							var lis = $("#pageCommNums a").not(":first").not(
								":last");
							var num = parseInt($(lis[0]).text());
							if (num >= 2) {
								$(lis[0]).text(num - 1);
								$(lis[1]).text(num);
								$(lis[2]).text(num + 1);
								$(lis[3]).text(num + 2);
								$(lis[4]).text(num + 3);
							}
						})
						$("#pageCommNums").append($navHead);
						if (pageCount > 4 && page >= pageCount - 4 && page <= pageCount) {
							var n = data[0] - 4;
							for (var num = 0; num < 5; num++) {
								var $li = $("<li><a href='javascript:void(0);'>" + n + "</a></li>");
								//alert($li.children()[0].text)
								$("#pageCommNums").append($li);
								n = n + 1;
							}
						} else {
							if (data[0] <= 4) {
								page = 1;
							}
							for (var num = 0; num < 5; num++) {
								if (page + num <= pageCount) {
									var $li = $("<li><a href='javascript:void(0);'>" + (page + num) + "</a></li>");
									//alert($li.children()[0].text)
									$("#pageCommNums").append($li);
								}
							}
						}
						var $navTail = $("<li><a href='javascript:void(0);'>&raquo;</a></li>");
						$navTail.click(function() {
							var lis = $("#pageCommNums a").not(":first").not(
								":last");
							var num = parseInt($(lis[1]).text());
							if (num < data[0] - 3) {
								$(lis[0]).text(num);
								$(lis[1]).text(num + 1);
								$(lis[2]).text(num + 2);
								$(lis[3]).text(num + 3);
								$(lis[4]).text(num + 4);
							}
						})
						$("#pageCommNums").append($navTail);
						$("#pageCommNums a").not(":first").not(":last").click(
							function() {
								var num = parseInt($(this).text());
								loadCommByPage(num);
							});
					},
					error: function(data) {
						$("#commList").html("請求失敗，請刷新頁面");
					}
				});
				//ajax 结束
				return false;	
			}//评论列表8-1 end
			
			/* 右边导航 */
			function active(obj){
				$(obj).parent().siblings().removeClass();
				$(obj).parent().addClass("active");
			}
			
			function onsave(){
				$('#userModify').data('bootstrapValidator').validate();
				if(!$('#userModify').data('bootstrapValidator').isValid()){
					return ;
				}
				$.ajax({
					url : 'modifyUser',
					type : 'post',
					data : $("#userModify").serialize(),
					dataType: "text",
					success : function(data){
						if(data=='success'){
							alert("修改用户信息成功");
						}else{
							alert("修改用户信息成功！密码改变请重新登陆");
							location.href = 'index.jsp';
						}
					}
				}); /*onsave-ajax*/
			}/*onsave-ending*/
			
			function onsavepwd(){
				$('#pwdModify').data('bootstrapValidator').validate();
				if(!$('#pwdModify').data('bootstrapValidator').isValid()){
					return ;
				}
				//取消提交旧密码和确认密码
				var $oldpwd=$('#oldpwd')
				$oldpwd.removeAttr("name");
				var userpwd=${sessionScope.user.pwd};
				$('#pwd2').removeAttr("name");
				if($oldpwd.val()!=userpwd){
					alert("旧密码输入不正确");
					return ;
				}
				$.ajax({
					url : 'modifyUser',
					type : 'post',
					data : $("#pwdModify").serialize(),
					dataType: "text",
					success : function(data){
						alert("修改用户信息成功！密码改变请重新登陆");
						location.href = 'index.jsp';
					}
				}); /*onsavepwd-ajax*/
			}/*onsavepwd-ending*/
			
			
			$(function () {
				
				
				//0.初始化fileinput
			    var oFileInput = new FileInput();
			    oFileInput.Init("txt_file", "inputIcon");
				loadPostByPage(1);
				loadCommByPage(1);
		        $('#userModify').bootstrapValidator({
		            message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            submitButtons: '#savebtn',
		            fields: {
		                accound: {
		                    message: '用户名验证失败',
		                    validators: {
		                        notEmpty: {
		                            message: '用户名不能为空'
		                        },
		                        stringLength: {
		                            min: 4,
		                            max: 20,
		                            message: '用户名长度必须在4到20位之间'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9_]+$/,
		                            message: '用户名只能包含大写、小写、数字和下划线'
		                        }
		                    }
		                }, 
		                petname: {
		                    validators: {
		                        notEmpty: {
		                            message: '昵称不能为空'
		                        },
		                        stringLength: {
		                            min: 4,
		                            max: 20,
		                            message: '昵称长度必须在4到20位之间'
		                        },
		                    }
		                },
		                phone: {
		                    validators: {
		                        notEmpty: {
		                            message: '地址不能为空'
		                        },
		                        regexp: {
		                            regexp: /^1[34578]\d{9}$/,
		                            message: '手机号码有误，请重填'
		                        }
		                    }
		                }
		                
		            }
		        });/* userModify结束 */
		        $('#pwdModify').bootstrapValidator({
		            message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            submitButtons: '#savepwdbtn',
		            fields: {
		                oldpwd: {
		                    validators: {
		                        notEmpty: {
		                            message: '密码不能为空'
		                        },
		                        stringLength: {
		                            min: 6,
		                            max: 20,
		                            message: '密码长度必须在6到20位之间'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9]+$/,
		                            message: '用户名只能包含大写、小写、数字'
		                        }
		                    }
		                },
		                pwd: {
		                    validators: {
		                        notEmpty: {
		                            message: '新密码不能为空'
		                        },
		                        stringLength: {
		                            min: 6,
		                            max: 20,
		                            message: '密码长度必须在6到20位之间'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9]+$/,
		                            message: '用户名只能包含大写、小写、数字'
		                        }
		                    }
		                },
		                pwd2: {
		                    validators: {
		                        notEmpty: {
		                            message: '密码不能为空'
		                        },
		                        identical:{
		                        	field:'pwd',
		                        	message:'两次密码输入不一致'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9]+$/,
		                            message: '密码只能包含大写、小写、数字'
		                        }
		                    }
		                },
		                
		            }
		        });/* userModify结束 */
		    });
			
			//更新js格式化json时间格式
			Date.prototype.Format = function (fmt) { //author: meizz 
			    var o = {
			        "M+": this.getMonth() + 1, //月份 
			        "d+": this.getDate(), //日 
			        "h+": this.getHours(), //小时 
			        "m+": this.getMinutes(), //分 
			        "s+": this.getSeconds(), //秒  
			    };
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			    for (var k in o)
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			    return fmt;
			}
			
			//初始化fileinput
			var FileInput = function () {
			    var oFile = new Object();
			
			    //初始化fileinput控件（第一次初始化）
			    oFile.Init = function(ctrlName, uploadUrl) {
			    var control = $('#' + ctrlName);
			
			    //初始化上传控件的样式
			    control.fileinput({
			        language: 'zh', //设置语言
			        uploadUrl: uploadUrl, //上传的地址
			        allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
			        showUpload: true, //是否显示上传按钮
			        //showCaption: false,//是否显示标题
			        browseClass: "btn btn-primary", //按钮样式     
			        dropZoneEnabled: false,//是否显示拖拽区域
			        //minImageWidth: 50, //图片的最小宽度
			        //minImageHeight: 50,//图片的最小高度
			        //maxImageWidth: 1000,//图片的最大宽度
			        //maxImageHeight: 1000,//图片的最大高度
			        maxFileSize: 10240,//单位为kb，如果为0表示不限制文件大小
			        //minFileCount: 0,
			        maxFileCount: 1, //表示允许同时上传的最大文件个数
			        enctype: 'multipart/form-data',
			        validateInitialCount:true,
			        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
			        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
			    });
			
			    //导入文件上传完成之后的事件
			    $("#txt_file").on("fileuploaded", function (e,data) {
			        $("#myModal").modal("hide");
			        alert("更改成功！");
			        var res=data.response;
			        $("#headIcon").attr("src",res.success);
			    });
			}
			    return oFile;
			};
		</script>
							
								
								
								
							<!--  个人已经发过的贴信息-->
							<div id="section-2" style="height: 20px;"></div>
							<div class="panel panel-danger">

								<div class="panel-heading">
									<h3 class="panel-title">
          							 个人已经发过的贴信息
        							</h3>
								</div>
								<div class="panel-body" style="min-height: 500px;_height:500px;">
									<div class="panel panel-default" style="background: 80% 10%;height: 50px;padding: 10px;">
										<span id="page2" style="float: right;"> 
										     <ul id="pageNums" class="pagination " style="margin-top: 0px; margin-left: 0px;"> </ul>
									   </span>
									</div>
									<table class="table table-hover" style="font-size: medium;">	
										
										<tbody id="postList">
										</tbody>
									</table>
								</div>

							</div>
							<script type="text/javascript">
								function deletePost(obj) {
									/*var tr=obj.parentNode.parentNode;
									var emps_table=document.getElementById("post");
									emps_table.removeChild(tr);*/
								}

								function allSelect(obj) {
									var checks = document.getElementsByName("selectname");
									if (obj.checked == true) {
										for (var i = 0; i < checks.length; i++) {
											checks[i].checked = true;
										}
									} else {
										for (var i = 0; i < checks.length; i++) {
											checks[i].checked = false;
										}
									}
								}

								function inverseSelect() {
									var checks = document.getElementsByName("selectname");
									for (var i = 0; i < checks.length; i++) {
										if (checks[i].checked == true) {
											checks[i].checked = false;
										} else {
											checks[i].checked = true;
										}
									}
								}
							</script>

							<!--  个人的评论信息-->
							<div class="panel panel-danger" id="section-3">

								<div class="panel-heading">
									<h3 class="panel-title">
								        个人的评论信息
								    </h3>
								</div>
								<div class="panel-body" style="min-height: 500px;_height:500px;">
									<div class="panel panel-default" style="background: 80% 10%;height: 50px;padding: 10px;">
										<span id="page3" style="float: right;"> 
										     <ul id="pageCommNums" class="pagination " style="margin-top: 0px; margin-left: 0px;"> </ul>
									   </span>
									</div>
									<table class="table table-hover" style="font-size: medium;">
									     
										<tbody id="commList">
										</tbody>
									</table>
								</div>

							</div>
							
							<!-- 修改密码 -->
							<div class="panel panel-danger" id="section-4">
								<div class="panel-heading">
									<h3 class="panel-title">
								    	修改密码
								    </h3>
								</div>
								<div class="panel-body" style="height: auto;">
									<div style="width: 70%;margin: 0px auto;">
										<form id="pwdModify">
												<input type="hidden" name="userid" value="${sessionScope.user.userid}"/>
									            <div class="form-group">
									                <label>旧密码</label>
									                <input type="text" class="form-control" name="oldpwd" id="oldpwd"/>
									            </div>
									            <div class="form-group">
									                <label>新密码</label>
									                <input type="password" class="form-control" name="pwd"/>
									            </div>
									            <div class="form-group">
									                <label>确认密码</label>
									                <input type="password" class="form-control" name="pwd2" id="pwd2"/>
									            </div>
									            <div class="form-group" style="text-align: center;">				    										
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<button type="button" class="btn btn-primary" id="savepwdbtn" onclick="onsavepwd();">
														保存修改
													</button>
												</div>
									     </form>
									</div>	
								</div>
							</div>
						</div>
					</div>
				</div>

				<div style="margin-left: -15px;">
					<p class="navbar-text navbar-left">
						© 20017-2017 Comsenz Inc. Powered by ABBS! X3.3 Designed by Z.cn
					</p>
					<p class="navbar-text navbar-right">手机版|ABBS动漫论坛 ( 粤ICP备16666601号</p>
				</div>
		</div>
	</body>
</html>
