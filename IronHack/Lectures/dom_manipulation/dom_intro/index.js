function generateRandomColor() {
    return '#'+Math.floor(Math.random()*16777215).toString(16);
  }


  function changeColor() {
      var discoBoxes = document.getElementsByClassName ("disco-box");

      for (i = 0; i<discoBoxes; i++) {
        discoBoxes[i].style.backgroundColor = generateRandomColor();

      }
  }

  setInterval(changeColor, 500)
