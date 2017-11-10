<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个性化搜索结果</title>
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

</head>
<body style="background: url(img/22.jpg) no-repeat fixed 50% 0; background-size: 100% 100%;">
        <div style="width: 71.3%; margin: 0 auto;">
           <!--头部＋导航＋搜索
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：头部＋导航＋搜索
            -->
			<div class="t9_top" style="width: 900px;">
				<div id="hd">
					<div class="wp">
						<!--注册/登录
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：欢迎注册/登录
           -->
						<div class="hdc cl">
							<h2>
							<a href="index.jsp" title="萌动动漫论坛"><img src="img/logo.png"
								alt="萌动动漫论坛" border="0"></a>
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

						<!--导航栏
                    	作者：763265137@qq.com
                    	时间：2017-07-27
                    	描述：导航栏
                    -->
			       <div id="nv">
						<a href="javascript:;" id="qmenu" onmouseover="delayShow(this, function () {showMenu({'ctrlid':'qmenu','pos':'34!','ctrlclass':'a','duration':2});showForummenu(45);})" initialized="true" class="">快捷导航</a>
						<ul>
								<li id="mn_forum"><a href="index.jsp" hidefocus="true">萌首页</a></li>
								<li <c:if test="${searchType=='请选择类型'}">class="a"</c:if> id="mn_N1771"><a href="toSeachPostResultPage?searchType=请选择类型&keyword=" hidefocus="true">萌搜搜索</a></li>
								<c:if test="${!empty sessionScope.user}">
									<li id="mn_Na033"><a href="myuser" hidefocus="true">个人信息</a></li>
								</c:if>
								<li <c:if test="${searchType=='动漫音乐'}">class="a"</c:if> id="mn_N2d81"><a href="toSeachPostResultPage?searchType=动漫音乐&keyword=" hidefocus="true">动漫音乐</a></li>
								<li <c:if test="${searchType=='游戏之声'}">class="a"</c:if> id="mn_N7b38"><a href="toSeachPostResultPage?searchType=游戏之声&keyword=" hidefocus="true">游戏之声</a></li>
								<li <c:if test="${searchType=='动画之家'}">class="a"</c:if> id="mn_Nbda6"><a href="toSeachPostResultPage?searchType=动画之家&keyword=" hidefocus="true">动画之家</a></li>
								<li <c:if test="${searchType=='小说分享'}">class="a"</c:if> id="mn_Na3de"><a href="toSeachPostResultPage?searchType=小说分享&keyword=" hidefocus="true">小说分享</a></li>
						</ul>
					</div>
					<!--搜索
			                	作者：763265137@qq.com
			                	时间：2017-07-27
			                	描述：搜索
			                -->
			     <form id="searchForm">
			                <div class="panel panel-default" style="width:100%;height:50px;margin-top:20px;opacity:0.5;">
				                 <div class="panel-body">
									<select id="searchType_search" class="form-control" style="width:150px;float:left;margin-top:-8px">
									    <option>请选择类型</option>
					                    <option>动漫音乐</option>
										<option>游戏之声</option>
										<option>动画之家</option>
										<option>小说分享</option>
									</select>
									<input id="searchType" name="searchType"  style="visibility:hidden;" value="${searchType}">
					                <input id="keyword" name="keyword" type="text" class="form-control" placeholder="请输入关键词" style="width:200px;float:left;margin-top:-8px"value="${keyword}">      
					                <input id="requestPageNum" name="requestPageNum"  style="visibility:hidden;" value="1"> 
					                <input id="searchBtn" class="btn btn-default" type="button" value="搜索" style="float:left;margin-top:-8px;margin-left:-50px" 
					                    onclick="clickSearchPostFirstPageByPtypeAndPname()">
					             </div>
			             </div>       
				</form>
       </div>
          <form  id="nav_form">
          
		          <div id="pageNav" >
		          <ul   class="pager" style="float:left;margin-top:-5px;">
		                  <li><a >当前第 </a></li>
				          <li><a > <input id="nav_requestPageNum_skip" type="text" style="width:30px;" value=""></a></li>
				          <li><a >页 </a></li>
				          <li><a href="javascript:void(0);" onclick="skipPageAtWill()">跳转 </a></li>
				          <li><a >共<span id="pageCount" ></span>页</a></li>
				             
		          </ul> 
                  <input id="nav_requestPageNum"name="requestPageNum"  style="visibility:hidden;"value=""></a>
		          <input id="nav_searchType" name="searchType"  style="visibility:hidden;" value="" >
				  <input id="nav_keyword" name="keyword"  style="visibility:hidden;" value="">  
				 
					
				  <ul id="nav"class="pager" style="float:right;margin-top:-5px">
		                       
		          </ul> 
		              
		         </div>
           </form>
          
          <div class="panel panel-danger" style="margin-top:27px;width:960px;" >

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
					<tbody id="resultView">

					</tbody>
				</table>

		</div>
		<script type="text/javascript" charset="UTF-8" src="js/searchResult.js"></script>
</body>
</html>