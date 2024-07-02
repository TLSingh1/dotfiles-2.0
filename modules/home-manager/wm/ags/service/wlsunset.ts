import { WlsunsetIndicator } from "widget/bar/buttons/SystemIndicators";

class Wlsunset extends Service {
  static {
    Service.register(
      this,
      {
        'changed': ['boolean'],
      },
      {
        'active': ['boolean', 'rw'],
      },
    );
  }

  #active = false;

  get active() {
    return this.#active;
  }

  set active(value) {
    this.#active = !this.active;
    this.changed("active")
  }

  constructor() {
    super();
    this.updateState();
  }

  updateState() {
    try {
      const pidof = Utils.exec(["pidof", "wlsunset"]);
      this.#active = pidof.length > 0;
    } catch (err) {
      console.log(err);
    }
  }

  toggle() {
    try {
      if (this.active) {
        Utils.execAsync(["pkill", "wlsunset"]);
      } else {
        Utils.execAsync(["wlsunset", "-T", "4001"]);
      }
      this.updateState();
    } catch (err) {
      console.log(err);
    }
  }
}

export default new Wlsunset
