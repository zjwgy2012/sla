<?php
function container() {
  echo <<<END
    <script src="js/table.js"></script>

    <div class="container">
      <div class="row">
        <div class="span12">
          <section id="tenrant_path">
            <div class="page-header">
              <h1>租户路径</h1>
            </div>

            <table class="table table-bordered table-striped data-table">
              <thead>
                <tr>
                  <th colspan="2">业务路径</th>
                  <th></th>
                  <th></th>
                </tr>
                <tr>
                  <th>源</th>
                  <th>目的</th>
                  <th class="nbt">路径节点</th>
                  <th class="nbt">所属租户</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>  

          </section>
        </div>
      </div>
    </div> <!-- /container -->

    <div id="modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3>实际流量</h3>
      </div>
      <div class="modal-body">
        <div id="plot-chart" class="chart" style="height:200px"></div>
      </div>
      <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
      </div>
    </div>

END;
}

include('template.php');

?>