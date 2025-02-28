document.addEventListener("turbo:before-cache", () => {
    let flash = document.querySelector("#flash-messages");
    if (flash) {
      flash.remove();
    }
  });
  