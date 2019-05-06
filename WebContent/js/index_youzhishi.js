var buttons = document.querySelectorAll(".radmenu .spe1");

for (var i=0, l=buttons.length; i<l; i++) {
  var button = buttons[i];
  button.onclick = setSelected;
}

function setSelected(e) {
    if (this.classList.contains("selected")) {
      this.classList.remove("selected");
      if (!this.parentNode.classList.contains("radmenu")) {
        this.parentNode.parentNode.parentNode.querySelector("a").classList.add("selected")
      } else {
        this.classList.add("show");
      }
    } else {
      this.classList.add("selected");
      if (!this.parentNode.classList.contains("radmenu")) {
        this.parentNode.parentNode.parentNode.querySelector("a").classList.remove("selected")
      } else {
        this.classList.remove("show");
      }
    }
    return false;
}

// 音乐代码控制
window.onload = function(){
  lanren.play();
}
var lanren = {
    changeClass: function(target, id) {
      var className = $(target).attr('class');
      var ids = document.getElementById(id);
      (className == 'on') ? $(target).removeClass('on').addClass('off'): $(target).removeClass('off').addClass('on');
      (className == 'on') ? ids.pause(): ids.play();
    },
    play: function() {
      document.getElementById('media').play();
    }
  }
  // 音乐代码结束
  $(function(){
    $(".radmenu > a").addClass("selected");
  })
  
//左侧导航
