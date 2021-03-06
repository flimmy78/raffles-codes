﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wzxqjh_mod.aspx.cs" Inherits="jzpl.wzxqjh_mod" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>物资申请变更</title>
    <link href="../../UI/CSS/common.css" rel="stylesheet" type="text/css" />
    <style type="text/css"> 
    #overLay{ width:100%; background:#E0E0E0;  position:absolute; top:0; left:0; display:none; opacity:0; filter:alpha(opacity=0);}
    #popuContent{ width:370px; line-height:20px;  display:none; position:absolute; z-index:100; background:#fff; border:2px solid #888888;}   
    </style>
    <script type="text/javascript">
    var isGoOn = true;
    function initWin()
    {       
        
    }
    function checkInput2()
    {        
        var prodSite= document.getElementById("DdlProdSite").value;
        var recDate = document.getElementById("TxtDate").value;
        var recPerson = document.getElementById("DdlReceiptPerson").value;
        var recPersonIC = document.getElementById("TxtIC").value;
        var recPersonContact = document.getElementById("TxtContact").value;
        var reqQty = document.getElementById("TxtRequireQty").value;
        var receiptDept = document.getElementById("DdlReceiptDept").value;
        var DDL_QH = document.getElementById("DDL_QH").value;
        if(prodSite=="0")
        {
            alert("请选择生产场地！");
            return false;
        }
        if (DDL_QH == "0") {
            alert("请选择缺货处理方式！");
            return false;
        }
        if(recDate==""||recDate==null)
        {
            alert("请输入接收时间！");
            return false;
        }
        if(recPerson=="0")
        {
            alert("请输入接收人姓名！");
            return false;
        }
        if(recPersonIC==""||recPersonIC==null)
        {
            alert("请输入接收人IC！");
            return false;
        }
        if(recPersonContact==""||recPersonContact==null)
        {
            alert("请输入接收人联系电话！");
            return false;
        }
        if(reqQty==""||reqQty==null||reqQty=="0")
        {
            alert("请输入需求数量！");
            return false;
        }     
        if(receiptDept==""||receiptDept==null)
        {
            alert("请输入接收部门！");
            return false;
        }
        if(!isGoOn) return false;
        return true;
    }
    
    function checkNum1(obj)
    {  
        //alert(obj.value); 
        if(!checkNum(obj))
        {  
            //alert("1");  
            isGoOn=false;       
            return false;
        }
        else
        {
            //alert(2);
            ration_qty_ = NullCovertToZero(document.getElementById("ration_qty").innerText);
            issued_qty_ = NullCovertToZero(document.getElementById("issued_qty").innerText);
            required_qty_ = NullCovertToZero(document.getElementById("required_qty").innerText);
            require_qty_ = NullCovertToZero(obj.value);
            //alert(ration_qty+','+issued_qty+','+required_qty+',');
            if(require_qty_>Math.min(Math.round(100000*ration_qty_) - Math.round(100000*issued_qty_),Math.round(100000*ration_qty_) - Math.round(100000*required_qty_))/100000)
            {
                alert("需求数量超出最多可申请数量（"+Math.min(Math.round(100000*ration_qty_) - Math.round(100000*issued_qty_),Math.round(100000*ration_qty_) - Math.round(100000*required_qty_))/100000+"）");
                isGoOn=false;
                obj.focus();
                return false;
            }
            
            isGoOn=true;
            return true;
        }
    }

    function NullCovertToZero(value)
    {
        
        if(value==""||value==null){
            return 0;
        }
        else{
            return parseFloat(value);
        }
    }
     function setOpacity(elem,current){
	//如果是ie浏览器
	if(elem.filters){ 
	elem.style.filter = 'alpha(opacity=' + current + ')';
    }
    else{ //否则w3c浏览器
	elem.style.opacity = current/100;
    }
	}
	
	function display_popudiv()
	{
	    alertEle = myf('popuContent'); 
	    obj = myf('overLay');
	    obj.style.display = 'block';
		//判断页面的高度是否超过浏览器工作区的高度
		if(document.body.offsetHeight>=document.documentElement.clientHeight){
			obj.style.height = document.body.offsetHeight + 'px'; 
		}else{
			obj.style.height = document.documentElement.clientHeight + 'px';
		}
		var currentOpacity = 0;
		//设置定时器timer1
		var timer1 = setInterval(
			function(){
				if(currentOpacity<=50){
					setOpacity(obj,currentOpacity);
					currentOpacity+=5;	
				}
				else{
					clearInterval(timer1);
				}
			}
		,50);
		alertEle.style.display = 'block';
		alertEle.style.left = (document.body.offsetWidth - alertEle.offsetWidth)/2 + 'px';
		alertEle.style.top = '100px';
		
		if(isie6())
		{
		
		IfrRef = myf('DivShim');
		IfrRef.style.display='block';
		IfrRef.style.visibility='visible';
		IfrRef.style.top='100px';
		IfrRef.style.left=(document.body.offsetWidth - alertEle.offsetWidth)/2 + 'px';
		IfrRef.style.height=alertEle.offsetHeight;
		IfrRef.style.width=alertEle.offsetWidth;
		IfrRef.style.zIndex=alertEle.style.zIndex -1;
		
		}
	}
	
	function close_popudiv()
	{
	    alertEle = myf('popuContent'); 
	    obj = myf('overLay');
	    alertEle.style.display = 'none';
		var currentOpe = 50;
		//设置定时器timer2
		var timer2 = setInterval(
			function(){
				if(currentOpe>=0){
					setOpacity(obj,currentOpe);
					currentOpe-=5;
				}
				else{
					obj.style.display = 'none';
					clearInterval(timer2);
				}
			}
		,50);
		
		if(isie6())
		{
		IfrRef = myf('DivShim');
		IfrRef.style.display='none';		
		}
	}
		
	function isie6()
    {
        var browser=navigator.appName 
        var b_version=navigator.appVersion 
        var version=b_version.split(";"); 
        var trim_Version=version[1].replace(/[ ]/g,"");  
        if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
        { 
            return true; 
        } 
        return false;
    }
    </script>
    <script type="text/javascript" src="../../UI/script/DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../UI/script/common.js"></script>
    
</head>
<body onload="javascript:initWin();">
<div id="overLay"></div>
    <form id="form1" runat="server">
    <input type="hidden" id="req_id" runat="server" />
    <div style="width:480px; height:660px;font-size:10pt">
    <table class="table1">
    <tr>
    <td>    
    <b>域：</b><span runat="server" id="contract"></span>&nbsp;&nbsp; <b>物资编码：</b><span runat="server" id="part_no"></span>   
    </td>
    </tr>
    <tr>
    <td>    
    <b>物资名称：</b><span runat="server" id="part_desc" ></span>   
    </td>
    </tr>
    <tr>
    <td>    
    <b>项目ID：</b><span runat="server" id="project_id"></span>   
    </td>
    </tr>
    <tr>
    <td>    
    <b>项目名称：</b><span runat="server" id="project_desc"></span>   
    </td>
    </tr>
    <tr>
    <td>    
    <b>申请顺序号：</b><span runat="server" id="mtr_seq_no"></span>&nbsp;&nbsp; <b>行号：</b> <span runat="server" id="mtr_line_no"> </span> 
    </td>
    </tr>
    <tr>
    <td>
    <b>定额数量：</b><span runat="server" id="ration_qty"></span>&nbsp;&nbsp; <b>已申请数量：</b><span runat="server" id="required_qty"></span>&nbsp;&nbsp; <b>已下发数量：</b><span runat="server" id="issued_qty"></span>
    </td>
    </tr>
    </table>
    <hr style="width:450px" />
    <table id="req_content">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="接收场地："></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="DdlProdSite" runat="server" Width="300px">
                        </asp:DropDownList><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="接收时间：" onfocus="WdatePicker();"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtDate" onfocus="WdatePicker();"
                            runat="server"></asp:TextBox><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="接收人："></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="DdlReceiptPerson" runat="server" Width="155px" AutoPostBack="True" OnSelectedIndexChanged="DdlReceiptPerson_SelectedIndexChanged"></asp:DropDownList><span style="color: #ff0000">*</span></td>
                    <td>
                    <u onclick="display_popudiv()" style="color:#0000ff; cursor:hand;">[添加]</u>
                    
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="IC："></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtIC" runat="server"></asp:TextBox><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="联系方式："></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtContact" runat="server"></asp:TextBox><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
        <tr>
            <td>
                接收部门：</td>
            <td>
                <asp:DropDownList ID="DdlReceiptDept" runat="server">
                </asp:DropDownList><span style="color: #ff0000">*</span></td>
            <td>
            </td>
        </tr>
                <tr>
                
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="分段："></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtBlock" runat="server"></asp:TextBox><span style="color: #ff0000"></span></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="系统："></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtSystem" runat="server"></asp:TextBox></td>
                    <td>
                    </td>
                </tr>
                <tr>        
                        
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="施工内容："></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtWorkContent" runat="server"></asp:TextBox></td>
                    <td>
                    </td>
                </tr>
                <tr>        
                        
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="需求数量：" ></asp:Label></td>
                    <td>
                        <asp:TextBox ID="TxtRequireQty" runat="server" onblur="return checkNum1(this);"></asp:TextBox><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CheckBox ID="ChkDz" runat="server" Text="吊装" /></td>
                    <td colspan="1">
                    </td>
                </tr>
               <tr>
                    <td>
                        缺料配送方式：</td>
                    <td>
                        <asp:DropDownList
                                ID="DDL_QH" runat="server">
                                <asp:ListItem Value="0">请选择</asp:ListItem>
                                <asp:ListItem Value="1">继续配送</asp:ListItem>
                                <asp:ListItem Value="2">取消配送</asp:ListItem>
                                <asp:ListItem Value="3">需确认</asp:ListItem>
                            </asp:DropDownList>
                        </asp:DropDownList><span style="color: #ff0000">*</span></td>
                    <td>
                    </td>
                </tr>
            </table>
            <hr style="width:450px" />
            <table style="width:450px"><tr><td style="text-align:right"></td><td style="text-align:right"><asp:Button ID="BtnSave" runat="server" Text="保存" CssClass="button_1" OnClick="mBtnSave_Click" OnClientClick="return checkInput2();"/>&nbsp;&nbsp;<input type="button" id="btnclose" name="btnclose" value="关闭" class="button_1" onclick="javascript:window.close();"/></td>
                </tr></table>
    </div>
     <div id="popuContent" style="z-index:100">
            <table style="font-size: 10pt; background: #000080; color: #FFFFFF; width: 100%">
                <tr>
                    <td>
                        添加接收人</td>
                    <td style="text-align: right">
                        <input type="button" value="x" style="height: 18px; width: 18px; font-size: 7pt;
                            padding: 0; vertical-align: middle; text-align: center" id="BtnQuitPopuWin1" onclick="close_popudiv();" /></td>
                </tr>
            </table>
            <table style="width:100%">
                <tr>
                    <td style="padding:5px">
                        姓名：
                    </td>
                    <td>
                    <asp:TextBox ID="TxtReceiptPersonName" runat="server" Width="260px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding:5px">
                        IC：
                    </td>
                    <td>
                    <asp:TextBox ID="TxtReceiptPersonIC" runat="server" Width="260px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding:5px">
                        联系电话：
                    </td>
                    <td>
                    <asp:TextBox ID="TxtReceiptPersonContact" runat="server" Width="260px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <hr />
            <table style="width:100%;margin-bottom:20px">
                <tr>
                    <td style="text-align:right;padding-right:20px">
                        <asp:Button ID="BtnAddPerson" runat="server" Text="确认" CssClass="button_1" OnClientClick="close_popudiv()" OnClick="BtnAddPerson_Click"  />&nbsp;
                        &nbsp;<input id="BtnCloseLackReasenPopuDiv" type="button" value="取消" class="button_1" onclick="close_popudiv();"/>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="objid" runat="server" />
            <asp:HiddenField ID="rowversion" runat="server" />
            </div>
            <iframe id="DivShim" src="javascript:false;" scrolling="no" frameborder="0" style="position:absolute; top:0px; left:1px; display:none;"></iframe>
    </form>
</body>
</html>
