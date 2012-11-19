<?php
function container() {
  echo <<<END

    <script src="js/libs/raphael.min.js"></script>
    <script src="js/map.js"></script>

    <div class="container">
      <div class="row">
        <div class="span12">
          <section id="global">
            <div class="page-header">
              <h1>Global settings</h1>
            </div>

            <div id="map">
            </div>

          </section>
        </div>
      </div>
    </div>

END;
}

include('template.php');

?>