$(function(){
  window.addEventListener("message", function(message){
    let data = message.data;

    if (data.setPlayerData){
      renderPlayerList(data.plist, data.st);
    }
    else if (data.closeList){
      $(".playerlist").hide();
    }
  });
});

function renderPlayerList(plist, st){
  $(".players").children().detach();
  
  let rendstr = "";
  let it = 1;
  let offcol = false;
  
  for (let i = 0; i < plist.length; i++){
    let litem = plist[i];

    if (litem.charname === undefined || litem.charname === "undefined") continue;

    if (it == 1){
      if (offcol){
        rendstr += `<div class="row rbordered hlight">`;
      }
      else{
        rendstr += `<div class="row rbordered">`;
      }
    }

    let supportstyle = "display:none;";

    if (litem.support){
      supportstyle = "";
    }

    let nameTemplate = "";

    if (st){
      if (litem.mod){
        nameTemplate = litem.charname + " <span style='color: #5daeff; font-size: 10px;'> [M]</span>";
      }
      else if (litem.admin){
        nameTemplate = litem.charname + " <span style='color: #59E74B; font-size: 10px;'> [A]</span>";
      }
      else if (litem.support){
        nameTemplate = litem.charname + " <span style='color: #ff8800; font-size: 10px;'> [S]</span>";
      }
      else {
        nameTemplate = litem.charname;
      }
    }
    else{
      nameTemplate = litem.charname;
    }

    rendstr +=
      `<div class="col-3 rbordered">
        <div class="row">
          <div class="col-lg">
          <span style="color: #ffff00">${litem.dbid}</span> - ${nameTemplate}
          </div>
        </div>
      </div>`;

    it++;
    
    if (it > 4){
      offcol = !offcol;
      it = 1;
      rendstr += "</div>";
    }
  }
  
  $(".players").append(rendstr);
  $(".playerlist").show();
}
