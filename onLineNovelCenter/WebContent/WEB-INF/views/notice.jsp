<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>公告</title>


	</head>
<!--
	7-30  发布公告的页面
-->
	<body>
		<div class="panel-body" style="padding: 10px;">
			<form class="">
				<div class="form-inline">
					<div class="form-group">
						<div class="form-group">
							<label >主题</label>
							<select id="ptype" class="form-control">
								<option selected="selected">公告</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label >标题</label> <input id="pname" style="height:20px;" type="text" class="form-control" placeholder="请输入公告標題">
					</div>
				</div>
				<div class="form-group" style="margin-top: 10px;" >
					<textarea id="content" class="form-control" rows="10" style="width:50%;height: 300px;"></textarea>
				</div>
			</form>
			<div style="padding:5px">
		    	<a id="publishPost" href="#" class="easyui-linkbutton">提交</a>
		    	<a id="clearForm"        href="#" class="easyui-linkbutton" >重置</a>
	    	</div>
		</div>
		<script type="text/javascript">
		$(function(){    
			 $('#publishPost').bind('click', function(){    
	          	   publishPost()  
	            });   
			 
			 $('#clearForm').bind('click', function(){    
				 clearForm(); 
	            }); 
         });  
		//发布帖子
		function publishPost() {
			var ptype = $("#ptype option:selected").val();
			var pname = $("#pname").val();
			var content = $("#content").val();
			content=content.replace(/\n|\r\n/g,"<br/>");
			if(pname.length==0) {
				alert("请输入标题");
				return false;
			}
				
			if(content.length==0){
				alert("请输入内容");
				return false;
			} 
				
			
			var data = {
				ptype : ptype,
				pname : pname,
				content :content
			};

			$.ajax({
				type : "POST",
				url : "publishPost",
				data : data,
				success : function(data) {
					//新增代码段
					var result = data;
					if (result == "true"){
						alert("发布公告成功");
						clearForm()
					}
						
					if (result == "false")
						alert("发布公告失败,请尝试再发布");
					if (result == "off_line")
						alert("您未登录,请先登录");
					
				},
				error : function(data) {

				}
			});

			return false;
		}
		//清理公告框
		function clearForm(){
			
			$("#pname").val("");
			$("#content").val("");
			
		}
		
		</script>
	</body>
</html>