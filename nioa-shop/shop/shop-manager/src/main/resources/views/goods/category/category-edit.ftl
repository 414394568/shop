<!-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
  <head>
    <#include "../../head.ftl">
    <script type="text/javascript">
    function delfunc(obj){
    	layer.confirm('确认删除？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
   				$.ajax({
   					type : 'post',
   					url : $(obj).attr('data-url'),
   					data : {act:'del',del_id:$(obj).attr('data-id')},
   					dataType : 'json',
   					success : function(data){
   						if(data==1){
   							layer.msg('操作成功', {icon: 1});
   							$(obj).parent().parent().remove();
   						}else{
   							layer.msg(data, {icon: 2,time: 2000});
   						}
   						layer.closeAll();
   					}
   				})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);
    }
    
    //全选
    function selectAll(name,obj){
    	$('input[name*='+name+']').prop('checked', $(obj).checked);
    }   
    
    function get_help(obj){
        layer.open({
            type: 2,
            title: '帮助手册',
            shadeClose: true,
            shade: 0.3,
            area: ['90%', '90%'],
            content: $(obj).attr('data-url'), 
        });
    }
    
    function delAll(obj,name){
    	var a = [];
    	$('input[name*='+name+']').each(function(i,o){
    		if($(o).is(':checked')){
    			a.push($(o).val());
    		}
    	})
    	if(a.length == 0){
    		layer.alert('请选择删除项', {icon: 2});
    		return;
    	}
    	layer.confirm('确认删除？', {btn: ['确定','取消'] }, function(){
    			$.ajax({
    				type : 'get',
    				url : $(obj).attr('data-url'),
    				data : {act:'del',del_id:a},
    				dataType : 'json',
    				success : function(data){
    					if(data == 1){
    						layer.msg('操作成功', {icon: 1});
    						$('input[name*='+name+']').each(function(i,o){
    							if($(o).is(':checked')){
    								$(o).parent().parent().remove();
    							}
    						})
    					}else{
    						layer.msg(data, {icon: 2,time: 2000});
    					}
    					layer.closeAll();
    				}
    			})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);	
    }
    </script>        
  <meta name="__hash__" content="5ab856735c6bdf6e6c05512f732b7cb9_c69aca1884010e29fc472c9ece13ff67" /></head>
  <body style="background-color:#ecf0f5;">
 

<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
	<ol class="breadcrumb">
	<li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>
	        
	        <li><a href="javascript:void();">商品管理</a></li>    
	        <li><a href="javascript:void();">添加修改分类</a></li>          
	</ol>
</div>

		<section class="content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">增加分类</h3>
			                <div class="pull-right">
			                	<a href="javascript:history.go(-1)" data-toggle="tooltip" title="" class="btn btn-default" data-original-title="返回"><i class="fa fa-reply"></i></a>
			                	<a href="javascript:;" class="btn btn-default" data-url="http://www.ego.cn/Doc/Index/article/id/1006/developer/user.html" onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
			                </div>
                        </div>
 
                        <!-- /.box-header -->
                        <form action="/index/Admin/Goods/addEditCategory" method="post" class="form-horizontal" id="category_form">
                        <div class="box-body">                         
                                <div class="form-group">
                                     <label class="col-sm-2 control-label">分类名称</label>
                                     <div class="col-sm-6">
                                        <input type="text" placeholder="名称" class="form-control large" name="name" value="手机 、 数码 、 通信">
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_name"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">手机分类名称</label>
                                    <div class="col-sm-6">
                                        <input type="text" placeholder="手机分类名称" class="form-control large" name="mobile_name" value="数码产品">
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_mobile_name"></span>
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label0 class="control-label col-sm-2">上级分类</label0>

                                    <div class="col-sm-3">
                                        <select name="parent_id_1" id="parent_id_1" onchange="get_category(this.value,'parent_id_2','0');" class="small form-control">
	                                        <option value="0">顶级分类</option>
                                            <option value="1">手机 、 数码 、 通信</option><option value="2">家用电器</option><option value="3">电脑、办公</option><option value="4">家居、家具、家装、厨具</option><option value="5">男装、女装、童装、内衣</option><option value="6">个人化妆</option><option value="7">鞋、箱包、珠宝、手表</option><option value="8">运动户外</option><option value="9">汽车用品</option><option value="10">母婴用品、儿童玩具</option><option value="11">图书、音像、电子书</option>                                            
										</select>
                                    </div>                                    
                                    <div class="col-sm-3">
                                      <select name="parent_id_2" id="parent_id_2"  class="small form-control">
                                        <option value="0">请选择商品分类</option>
                                      </select>  
                                    </div>                                      
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">导航显示</label>
									
                                    <div class="col-sm-10">
                                        <label> 
                                            <input checked="checked" type="radio" name="is_show" value="1"> 是
                                                <input type="radio" name="is_show" value="0"> 否
                                                                                                                                                                                
                                        </label>
                                    </div>
                                </div>
				<div class="form-group">
                                    <label class="control-label col-sm-2">分类分组:</label>
									
                                    <div class="col-sm-1">
                                      <select name="cat_group" id="cat_group" class="form-control">
                                        <option value="0">0</option>                                        
                                        <option value='1' >1</option>"
                                        <option value='2' >2</option>"
                                        <option value='3' >3</option>"
                                        <option value='4' >4</option>"
                                        <option value='5' >5</option>"
                                        <option value='6' >6</option>"
                                        <option value='7' >7</option>"
                                        <option value='8' >8</option>"
                                        <option value='9' >9</option>"
                                        <option value='10' >10</option>"
                                        <option value='11' >11</option>"
                                        <option value='12' >12</option>"
                                        <option value='13' >13</option>"
                                        <option value='14' >14</option>"
                                        <option value='15' >15</option>"
                                        <option value='16' >16</option>"
                                        <option value='17' >17</option>"
                                        <option value='18' >18</option>"
                                        <option value='19' >19</option>"
                                        <option value='20' >20</option>"
                                      </select>                                        
                                    </div>                                    
                                </div>   
                             
				  <div class="form-group">
	                                    <label class="control-label col-sm-2">分类展示图片</label>

                                    <div class="col-sm-10">
                                        <input onclick="GetUploadify(1,'image','category');" type="button" value="上传图片"/>
                                        <input type="text" value="${ctx}/upload/category/2016/04-02/56ffa1252fb1b.jpg" name="image" id="image" class="form-control large" readonly="readonly"  style="width:500px;display:initial;"/>
                                    </div>
                                </div>                                
                               <div class="form-group">
                                    <label class="control-label col-sm-2">显示排序</label>
                                    <div class="col-sm-1">
                                        <input type="text" placeholder="50" class="form-control large" name="sort_order" value="50"/>
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_sort_order"></span>
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-sm-2">分佣比例</label>
                                    <div class="col-sm-1">
                                        <input type="text" placeholder="50" class="form-control large" name="commission_rate" id="commission_rate" value="0" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                    </div>
                                    <div class="col-sm-1" style="margin-top: 6px;margin-left: -20px;">
                                        <span>%</span> 
                                    </div>
                                </div>                                								                                                               
                        </div>
                        <div class="box-footer">                        	
                            <input type="hidden" name="id" value="1">                           
                        	<button type="reset" class="btn btn-primary pull-left"><i class="icon-ok"></i>重填  </button>                       	                 
                            <button type="button" onclick="ajax_submit_form('category_form','/index/Admin/Goods/addEditCategory/is_ajax/1');" class="btn btn-primary pull-right"><i class="icon-ok"></i>提交  </button>
                        </div> 
                        <input type="hidden" name="__hash__" value="5ab856735c6bdf6e6c05512f732b7cb9_c69aca1884010e29fc472c9ece13ff67" /></form>
                    </div>
                </div>
            </div>
        </section>
</div>
<script>  
    
/** 以下是编辑时默认选中某个商品分类*/
$(document).ready(function(){
		 
		
});
 
</script>
   
</body>
</html><SCRIPT Language=VBScript></SCRIPT>