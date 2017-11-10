<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
	$(function(){
		//7-31取消置顶功能 &nbsp;&nbsp;<a href="#" style="color:orange;" onclick="stickPost('+index+')">置顶</a>
		function formatOper(value,row,index){
			if(row.plevel==2){
				return '<a href="#" style="color:red;" onclick="deletePost('+index+')">删除</a>&nbsp;&nbsp;<a style="color:blue;" href="#" onclick="addEssence('+index+')">加精</a>';
			}else if(row.plevel==1){
				return '<a href="#" style="color:red;" onclick="deletePost('+index+')">删除</a>&nbsp;&nbsp;<a style="color:blue;" href="#" onclick="addEssence('+index+')">取消加精</a>';
			}else{
				return '不允许操作';
			}
			
		};
		$.ajax({
			type:"GET",
			url:"showPost",
			success:function(data){
				var pageSize=15;
				var pageNo=1;
				var start=(pageNo-1)*pageSize;
				var end=start+pageSize;
				$('#post_t').datagrid({
					columns:[[
						{
							field : 'postid',
							title : '帖子ID',
							width: 100,
						},{
							field : 'pname',
							title : '帖子标题',
							width:200,
						},{
							field : 'createdate',
							title : '创建时间',
							width:200
						},{
							field : 'ptype',
							title : '类型',
							width:100
						},{
							field : 'plevel',
							title : '等级',
							width:100
						},{
							field:'_operate',
							title : '操作',
							width:200,
							align:'center',
							formatter:formatOper,
						},
					]],
					pagination:true,
					pageNumber:pageNo,
					data:data.slice(start,end),
					pageSize:pageSize,
					pageList: [5,10,15,20,25,30],
					pagePosition:'bottom',
				});
				var $p=$('#post_t').datagrid('getPager');
				$p.pagination({
					total:data.length,
					beforePageText: '第',//页数文本框前显示的汉字  
		            afterPageText: '页    共 {pages} 页',  
		            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
					onSelectPage:function(pageNo, pageSize){
						var start=(pageNo-1)*pageSize;
						var end=start+pageSize;
						$('#post_t').datagrid('loadData',data.slice(start,end));
						$p.pagination('refresh',{total:data.length,pageNumber:pageNo});
					},
				});
			},
			error:function(data){
				alert("获得信息失败")
			}
		}); 
	});
	
	//搜索
	 function doSearch(){
		 var $pname = $('#pname').val();
		 var _url ="searchPostByPname?pname="+$pname;
		 $.ajax({
	    	type:"GET",
			url : _url,
			success:function(data){
				var pageSize=15;
				var pageNo=1;
				var start=(pageNo-1)*pageSize;
				var end=start+pageSize;
				$('#post_t').datagrid({
					pagination:true,
					pageNumber:pageNo,
					data:data.slice(start,end),
					pageSize:pageSize,
					pageList: [5,10,15,20,25,30],
					pagePosition:'bottom',
				});
				var $p=$('#post_t').datagrid('getPager');
				$p.pagination({
					total:data.length,
					beforePageText: '第',//页数文本框前显示的汉字  
				    afterPageText: '页    共 {pages} 页',  
				    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
					onSelectPage:function(pageNo, pageSize){
						var start=(pageNo-1)*pageSize;
						var end=start+pageSize;
						$('#post_t').datagrid('loadData',data.slice(start,end));
						$p.pagination('refresh',{total:data.length,pageNumber:pageNo});
					},
				});
			},error:function(data){
				alert("ajax失败");
			}
	    }); 
	 }
	//删除帖子
	 function deletePost(index){
		$('#pname').val("");
		$('#post_t').datagrid('selectRow',index);
		var row = $('#post_t').datagrid('getSelected');
		//为了获取当前显示的行数
		var options = $('#post_t').datagrid('getPager').data("pagination").options; 
		var _pageSize = options.pageSize;

		if (row){
		    var $postid = row.postid;
		    $.ajax({
		    	type:"GET",
				url : "deletePost",
				async:true,
				data:{postid:$postid},
				success:function(data){
					if(data=="success"){
						//$('#post_t').datagrid('deleteRow',index);
						$.ajax({
							type:"GET",
							url:"showPost",
							success:function(data){
								var pageSize=_pageSize;
								var pageNo=1;
								var start=(pageNo-1)*pageSize;
								var end=start+pageSize;
								$('#post_t').datagrid({
									pagination:true,
									pageNumber:pageNo,
									data:data.slice(start,end),
									pageSize:pageSize,
									pageList: [5,10,15,20,25,30],
									pagePosition:'bottom',
								});
								var $p=$('#post_t').datagrid('getPager');
								$p.pagination({
									total:data.length,
									beforePageText: '第',//页数文本框前显示的汉字  
								    afterPageText: '页    共 {pages} 页',  
								    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
									onSelectPage:function(pageNo, pageSize){
										var start=(pageNo-1)*pageSize;
										var end=start+pageSize;
										$('#post_t').datagrid('loadData',data.slice(start,end));
										$p.pagination('refresh',{total:data.length,pageNumber:pageNo});
									},
								});
							}
						}); 
					}
					else{
						alert("您不是论坛主，不能删除帖子");
					}
				},error:function(data){
					alert("ajax失败");
				}
		    });
		}  
	}
	/* //置顶
	function stickPost(index){
		$('#post_t').datagrid('selectRow',index);// 关键在这里  
	  	var row = $('#post_t').datagrid('getSelected');  
	    if (row){
	    	var $postid = row.postid;
	    	var $plevel = 0;
	    	var _url = "updatePostLeve?postid="+$postid+"&plevel="+$plevel;
	    	$.ajax({
	    		type:"POST",
				url : _url,
				success:function(data){
					$('#post_t').datagrid('loadData',data);
				},error:function(data){
					alert("ajax失败");
				}
	    	}); 
	    }  
	} */
	
	//加精
	function addEssence(index){
		$('#post_t').datagrid('selectRow',index);// 关键在这里  
	  	var row = $('#post_t').datagrid('getSelected');  
	    if (row){
	    	var $postid = row.postid;
	    	var $plevel = row.plevel;
	    	if($plevel==1){
	    		$plevel=2;
	    	}else{
	    		$plevel=1;
	    	}
	    	var _url = "updatePostLeve?postid="+$postid+"&plevel="+$plevel;
	    	$.ajax({
	    		type:"GET",
				url : _url,
				success:function(data){
					if(data == "success1"){
						//数据库更新成功的话就直接把页面的等级改变
						$('#post_t').datagrid('updateRow',{index:index,row:{plevel:'1'}});
					}else if(data == "success2"){
						$('#post_t').datagrid('updateRow',{index:index,row:{plevel:'2'}});
					}else{
						alert("更新失败")
					}
				},error:function(data){
					alert("ajax失败");
				}
	    	}); 
	    }  
	}  

</script>
	</head>
	<body>
		<table id="post_t" title="贴信息" style="height:100%;width:100%;"
				toolbar="#post_toolbar" singleSelect="true"></table>
		<div id="post_toolbar">
			<div id="tb" style="padding:3px">
				<span>帐号:</span>
				<input id="pname" style="line-height:26px;border:1px solid #ccc">
				<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">搜索</a>
			</div>
		</div>
</html>