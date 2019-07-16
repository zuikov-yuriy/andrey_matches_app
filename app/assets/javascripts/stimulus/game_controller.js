(() => {
  stimulus.register("game", class extends Stimulus.Controller {
    static get targets() {
      return [ "output" ]
    }
    
    initialize() {
      console.log('init game controller');
    }

    up(_event) {
      const element = this.nameTarget
      const match_id = element.match_id
      console.log('match_id=',match_id);
      console.log('id=',this.element);
      // fetch("/matches/"+1+"/up",{method: 'POST',
      //     headers: {
      //       'Content-Type': 'application/json;charset=UTF-8',
      //       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      //     },
      //   }).then(data => console.log(JSON.stringify(data)))
    }

    down () {

    }

    uptotal() {
      console.log('uptotal call...');
    }

    connect() {
      this.outputTarget.textContent = 'Hello, Stimulus!'
    }
   
  })
})()
