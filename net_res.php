<?php 
function container() {
  echo <<<END
    <script src="js/topology.js"></script>
    <script src="js/map.js"></script>

    <div class="container">
      <div class="row">
        <section id="global">
          <div class="page-header">
            <h1>网络资源</h1>
          </div>
          
          <div class="topology">
            <div id="map"></div>
            <div id="tpl" class="node router"></div>
          </div>

        </section>
      </div>
    </div> 

END;
}

include 'template.php';

?>
    


    


    
