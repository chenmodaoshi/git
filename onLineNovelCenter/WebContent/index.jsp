<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>动漫BBS</title>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
		
		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrapValidator.css" />
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrapValidator.js" ></script>

		<link rel="stylesheet" type="text/css" href="css//style_46_common.css">
		<link rel="stylesheet" type="text/css" href="css//style_46_forum_forumdisplay.css">

		<script src="js/hm.js" type="text/javascript"></script>
		<script src="js/forum.js" type="text/javascript"></script>
		<script type="text/javascript" charset="UTF-8" src="js/common_extra.js"></script>
		<script type="text/javascript" charset="UTF-8" src="js/index.js"></script>
	</head>

	<body style="background: url(img/22.jpg) no-repeat fixed 50% 0; background-size: 100% 100%;">

		<div style="width: 71.3%; margin: 0 auto;">
			<div class="t9_top" style="width: 960px;">
				<div id="hd">
					<div class="wp" >
						<div class="hdc cl">
							<h2>
							<a href="#" title="Animation_BBS"><img src="img/logo.png"
								alt="Animation_BBS" border="0"></a>
							</h2>
							<div class="fastlg cl">
								<div class="y pns">
									<table cellspacing="0" cellpadding="0">
										<tbody>
											<tr>
												<c:if test="${empty sessionScope.user}">
													<td class="fastlg_l">
														<!-- 按钮触发模态框 -->
														<button class="btn btn-primary" data-toggle="modal" data-target="#lmodal">
															登录
														</button>
														<!-- 模态框（Modal） -->
														<div class="modal fade" id="lmodal">
															<div class="modal-dialog" style="width: 300px;">
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																		X
																		</button>
																		<h4 class="modal-title" id="myModalLabel">
																			欢迎登录
																		</h4>
																	</div>
																	<div class="modal-body">
																		<form id="login">
																            <div class="form-group">
																                <label>账号</label>
																                <input type="text" class="form-control" id="accound" name="accound"/>
																            </div>
																            <div class="form-group">
																                <label>密码</label>
																                <input type="password" class="form-control" id="pwd" name="pwd"/>
																            </div>											
																            <div class="form-group" style="text-align: center;">
																	            <button type="button" class="btn btn-default" data-dismiss="modal">取消
																				</button>
																				<button type="button" class="btn btn-primary" id="loginbtn" onclick="onlogin();">
																				登录
																				</button>
																			</div>
																        </form>
																	</div>
																</div><!-- /.modal-content -->
															</div><!-- /.modal-dailog -->
														</div><!-- /.modal -->
													</td>
													<td>
														<!-- 按钮触发模态框 -->
														<button class="btn btn-primary" data-toggle="modal" data-target="#rmodal">
															注册
														</button>
														<!-- 模态框（Modal） -->
														<div class="modal fade" id="rmodal">
															<div class="modal-dialog" style="width: 300px;">
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																		X
																		</button>
																		<h4 class="modal-title" id="myModalLabel">
																			欢迎注册
																		</h4>
																	</div>
																	<div class="modal-body">
																		<form id="register">
																            <div class="form-group">
																                <label>账号</label>
																                <input type="text" class="form-control" name="accound"/>
																            </div>
																            <div class="form-group">
																                <label>密码</label>
																                <input type="password" class="form-control" name="pwd"/>
																            </div>
																            <div class="form-group">
																                <label>确认密码</label>
																                <input type="password" class="form-control" name="pwd2"/>
																            </div>
																            <div class="form-group">
																                <label>昵称</label>
																                <input type="text" class="form-control" name="petname"/>
																            </div>
																            <div class="form-group">
																                <label>性别</label>
																                <select class="form-control" name="sex">
																				  <option>男</option>
																				  <option>女</option>
																				</select>
																            </div>
																            <div class="form-group">
																                <label>手机号码</label>
																                <input type="text" class="form-control" name="phone"/>
																            </div>
																            <div class="form-group" style="text-align: center;">
																	            <button type="button" class="btn btn-default" data-dismiss="modal">取消
																				</button>
																				<button type="button" class="btn btn-primary" id="registerbtn" onclick="onregister();">
																				注册
																				</button>
																			</div>
																        </form>
																	</div>
																</div><!-- /.modal-content -->
															</div><!-- /.modal-dailog -->
														</div><!-- /.modal -->
													</td>
												</c:if>
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
						<div id="nv">
							<a href="javascript:;" id="qmenu" onmouseover="delayShow(this, function () {showMenu({'ctrlid':'qmenu','pos':'34!','ctrlclass':'a','duration':2});showForummenu(45);})" initialized="true" class="">快捷导航</a>
							<ul>
								<li class="a" id="mn_forum"><a href="#" hidefocus="true">萌首页</a></li>
								<li id="mn_N1771"><a href="toSeachPostResultPage?searchType=请选择类型&keyword=" hidefocus="true">萌搜搜索</a></li>
								<c:if test="${!empty sessionScope.user}">
									<li id="mn_Na033"><a href="myuser" hidefocus="true">个人信息</a></li>
								</c:if>
								<li id="mn_N2d81"><a href="toSeachPostResultPage?searchType=动漫音乐&keyword=" hidefocus="true">动漫音乐</a></li>
								<li id="mn_N7b38"><a href="toSeachPostResultPage?searchType=游戏之声&keyword=" hidefocus="true">游戏之声</a></li>
								<li id="mn_Nbda6"><a href="toSeachPostResultPage?searchType=动画之家&keyword=" hidefocus="true">动画之家</a></li>
								<li id="mn_Na3de"><a href="toSeachPostResultPage?searchType=小说分享&keyword=" hidefocus="true">小说分享</a></li>
							</ul>
						</div>
	                    <form id="searchForm" method="GET" accept-charset="UTF-8">
			                 <div class="panel panel-default" style="width:100%;height:50px;margin:0px auto;opacity:0.5;">
			                 		<a href="#goTie" class="btn btn-danger" style="float: right;margin-top:8px;z-index:1;">发新帖</a>
					                 <div class="panel-body">
										<select id="selectType" class="form-control" style="width:150px;float:left;margin-top:-8px">
										    <option>请选择类型</option>
						                    <option>动漫音乐</option>
											<option>游戏之声</option>
											<option>动画之家</option>
											<option>小说分享</option>
										</select>
										<input id="searchType"name="searchType"  style="visibility:hidden;" value="">
						                <input id="keyword"   name="keyword" type="text" class="form-control" placeholder="请输入关键词" style="width:200px;float:left;margin-top:-8px">      
						                <input id="searchBtn"  class="btn btn-default" type="button" value="搜索" style="float:left;margin-top:-8px;margin-left:-50px">
						             </div>
				             </div>       
						</form>
					</div>
				</div>
			</div>
			<!--图片-->
			<div class="panel panel-danger" style="width: 960px;">
				<img src="img/top1.jpg" class="img-responsive"/>
				<div class="panel-body">
					欢迎大家分享音乐，不管是游戏的，还是动漫的，还是国外金曲，或者是华语经典都是可以分享的。分享你我，分享快乐。现在还有Hi-res资源了哦~
					<br /> <br />
					<font style="color: red;">搜索提示：</font><br /> 因为这里分享的音乐大多数用的是中文标题，所以你用日文搜索动漫名字一般是找不到的，你可以直接搜索中文名字。最好的办法是搜索歌名，歌名肯定是日文不会错，你找歌名一般能够找到，找不到的话就说明没有这个音乐。
					<br /> 比如你要搜索【廻るセカイで永遠なるチカイを! オリジナルサウンドトラック】，用DZ自带的搜索引擎你就要搜索【運命≠STARTLiNE】，因为是游戏“在轮回的世界中定下永恒的誓言”的主题曲。用导航栏的“萌搜搜索”可以直接搜索游戏日文名，因为那个搜索引擎是连主题内容一起搜索的，不过有时候可能不准确。
					<br />
					<br /> 如果你想找专辑，一个专辑十几首音乐，标题不可能一个个写完。如果有专辑名称的话就直接搜索专辑名称，没有的话你直接搜索专辑第一首歌曲就行了。
					<br /> 如果歌曲收录在OST里面，那么你也可以直接搜索第一首歌曲，注意是歌曲，不是BGM。 <br /> <br /> 标题涉及到的特殊符号均为半角符号，但是如果要带特殊符号搜索的话，建议删掉特殊符号或者用空格代替。
				</div>
			</div>

			<!--推荐主题-->
			<div class="panel panel-danger" style="width: 960px;">
				<div class="panel-heading">
					<h3 class="panel-title">推荐主题</h3>
				</div>
				<div class="panel-body">
					因为这里分享的音乐大多数用的是中文标题，所以你用日文搜索动漫名字一般是找不到的，你可以直接搜索中文名字。最好的办法是搜索歌名，歌名肯定是日文不会错，你找歌名一般能够找到，找不到的话就说明没有这个音乐。 比如你要搜索【廻るセカイで永遠なるチカイを! オリジナルサウンドトラック】，用DZ自带的搜索引擎你就要搜索【運命≠STARTLiNE】，因为是游戏“在轮回的世界中定下永恒的誓言”的主题曲。用导航栏的“萌搜搜索”可以直接搜索游戏日文名，因为那个搜索引擎是连主题内容一起搜索的，不过有时候可能不准确。 如果你想找专辑，一个专辑十几首音乐，标题不可能一个个写完。如果有专辑名称的话就直接搜索专辑名称，没有的话你直接搜索专辑第一首歌曲就行了。
					如果歌曲收录在OST里面，那么你也可以直接搜索第一首歌曲，注意是歌曲，不是BGM。 标题涉及到的特殊符号均为半角符号，但是如果要带特殊符号搜索的话，建议删掉特殊符号或者用空格代替。
				</div>
			</div>
            <div class="panel panel-default" style="background: 80% 10%;height: 50px;padding: 10px;width: 960px;">				
				<button href="#goTie" type="button" class="btn btn-danger" style="float: left;">发新帖</button>
				<span id="page2" style="float: right;">
				     <button type="button" class="btn" style="margin-top: 0px;float:left;" >第</button>
				     <input id="pageNum" type="text" class="form-control" placeholder="页码" style="margin-top:0px;width:60px;float:left">
				     <button type="button" class="btn" style="margin-top: 0px;float:left;" >页</button> 
				     <button type="button" class="btn" style="margin-top: -60px;" onclick="skipPage()">跳转</button>
				     <ul id="pageNums" class="pagination " style="margin-top: 0px; margin-left: 0px;"> </ul>
				     <button id="pageCount"type="button" class="btn" style="margin-top: 0px;float:right;" >总页数</button>
				     <button id="currentPage"type="button" class="btn" style="margin-top: 0px;float:right;" >当前页</button>
			   </span>
			</div>
            
			

			<div class="panel panel-danger" style="width: 960px;">

				<table class="table table-hover" style="font-size: medium;">
					<thead>
						<tr class="danger">
							<th width="20%">主题</th>
							<th width="40%">标题</th>
							<th>作者</th>
							<th>回复/查看</th>
							<th>最新回复时间</th>
						</tr>
					</thead>
					<tbody id="postList">

					</tbody>
				</table>

			</div>

			<!--发帖  -->
			<div class="panel panel-danger" id="goTie" style="width: 960px;">
				<div class="panel-heading">
					<h3 class="panel-title">快速发帖</h3>
				</div>
				<div class="panel-body">

					<form class="">
						<div class="form-inline">
							<div class="form-group">
								<div class="form-group">
									<label class="form-control">主题</label> 
									  <select id="ptype" class="form-control">
									        <option>请选择类型</option>
											<option>动漫音乐</option>
											<option>游戏之声</option>
											<option>动画之家</option>
											<option>小说分享</option>
								      </select>
								</div>

							</div>
							<div class="form-group">
								<label class="form-control">标题</label> <input id="pname" type="text" class="form-control"  placeholder="请输入帖子标题">
							</div>
						</div>

						<div class="form-group" style="margin-top: 10px;">
							<textarea id="content"class="form-control" rows="3"></textarea>
						</div>
						<input type="button" value="提交" class="btn btn-default" onclick="publishPost()"/>
					</form>

				</div>
			</div>

			<div style="margin-left: -15px;">
				<p class="navbar-text navbar-left">© 2001-2013 Comsenz Inc. Powered by ABBS! X3.3 Designed by Z.cn</p>
				<p class="navbar-text navbar-right">手机版|ABBS动漫论坛 ( 粤ICP备16666601号</p>
			</div>
		</div>
	</body>
</html>