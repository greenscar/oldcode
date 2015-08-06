<?php
    $title = "Search";
    $image = "map.jpg";
    $bgcolor = "9B350B";
    include("./page_header.inc");
?>
            <table class="body">
               <tr>
                  <td>
                     <p>
                        <form method="GET" action="http://www.dbates.com/cgi-bin/htsearch">
                           <font size="-1">
                              Match: <select name="method">
                                       <option value="and">All
                                       <option value="or">Any
                                       <option value="boolean">Boolean
                                     </select>
                              Format: <select name="format">
                                       <option value="builtin-long">Long
                                       <option value="builtin-short">Short
                                      </select>
                              Sort by: <select name="sort">
                                          <option value="score">Score
                                          <option value="time">Time
                                          <option value="title">Title
                                          <option value="revscore">Reverse Score
                                          
                                          <option value="revtime">Reverse Time
                                          <option value="revtitle">Reverse Title
                                       </select>
                           </font>
                           <input type="hidden" name="config" value="htdig">
                           <input type="hidden" name="restrict" value="">
                           <input type="hidden" name="exclude" value="">
                           <br>
                           Search:
                           <input type="text" size="30" name="words" value="">
                           <input type="submit" value="Search">
                        </form>
                     </p>
                  </td>
               </tr>
            </table>    
<?php 
    $color = "white";
    include("./page_footer.inc");
?>