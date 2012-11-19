<?php
function get_file_name() {
  $arr = explode('/', $_SERVER['SCRIPT_NAME']);
  $arr = explode('.', $arr[count($arr)-1]);
  return $arr[0];
}

function active_or_not($menu, $class='active') {
  if($menu == get_file_name())
    print $class;
}

system("coffee -c js/*.coffee")

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>多租户SLA管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="css/docs.css" rel="stylesheet">
    <link href="css/common.css" rel="stylesheet">

    <!-- Le javascript
    ================================================== -->
    <script src="js/libs/jquery-latest.min.js"></script>
    <script src="js/libs/jquery-ui.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/jquery.jsoncookie.js"></script>
    <script src="js/libs/jquery.jsPlumb.min.js"></script>
    <script src="js/libs/jquery.flot.min.js"></script>
    <script src="js/libs/jquery.dataTables.min.js"></script>
    <script src="js/libs/jquery.dataTables.bootstrap.min.js"></script>
    <script src="js/libs/raphael.min.js"></script>
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar  navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="index.php">多租户SLA管理系统</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="<?php active_or_not('index') ?>"><a href="index.php">首页</a></li>
              <li class="<?php active_or_not('net_res') ?>"><a href="net_res.php">网络资源</a></li>
              <li class="<?php active_or_not('tenant_net') ?>"><a href="tenant_net.php">租户网络</a></li>
              <li class="<?php active_or_not('biz_path') ?>"><a href="biz_path.php">业务路径</a></li>
              <li class="<?php active_or_not('net_use') ?>"><a href="net_use.php">网络利用</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

 <?php 
   container();
 ?>
<!--     
    <footer class="footer">
      <div class="container">
        <p class="pull-right"><a href="#">返回顶端</a></p>
        <a href="pageManagement.do?method=getPageManagement&code=legalstatement" title="法律声明">法律声明</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="aboutUs.do?method=contactUs" title="联系我们">联系我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="aboutUs.do?method=doSubscribeNewsletter" title="华为终端快报">华为终端快报</a>&nbsp;&nbsp;
        
        <p>版权所有 &copy; 华为技术有限公司 1998-2012。 保留一切权利。(<a href="http://www.miibeian.gov.cn/" target="_blank">粤A2-20044005号-6</a>)</p>
      </div>
    </footer>
 -->

  </body>
</html>