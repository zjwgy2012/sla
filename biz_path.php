<?php 
function container() {
  echo <<<END

    <script src="js/topology.js"></script>

    <div class="container">
      <div class="row">
        <div class="span12">
          <section id="global">
            <div class="page-header">
              <h1>业务路径</h1>
            </div>
            
            <div>
              <div id="t1" class="well node">t1<div class="ep"><i class="icon-share-alt"></i></div></div>
              <div id="t2" class="well node">t2<div class="ep"><i class="icon-share-alt"></i></div></div>
              <div id="t3" class="well node">t3<div class="ep"><i class="icon-share-alt"></i></div></div>
              <div id="t4" class="well node">t4<div class="ep"><i class="icon-share-alt"></i></div></div>
              <div id="t5" class="well node">t5<div class="ep"><i class="icon-share-alt"></i></div></div>
            </div>

          </section>


        </div>
      </div>
    </div> 

END;
}

include 'template.php';

?>
    


    


    
