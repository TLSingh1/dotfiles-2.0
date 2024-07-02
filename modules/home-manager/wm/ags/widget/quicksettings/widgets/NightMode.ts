import { SimpleToggleButton } from "../ToggleButton"
import icons from "lib/icons"
import options from "options"

const { nightLight } = options.theme

const wlsunsetToggle = () => {
  try {
    const pidof = Utils.exec(["pidof", "wlsunset"])
    if (pidof.length > 0) {
      Utils.execAsync(["pkill", "wlsunset"]).catch(err => console.log(err))
    } else {
      Utils.execAsync(["wlsunset", "-T", "4001"]).catch(err => console.log(err))
    }
  } catch (err) {
    console.log(err)
  }
}

export const NightModeToggle = () => SimpleToggleButton({
  icon: nightLight.bind().as(s => icons.color[s]),
  label: nightLight.bind().as(s => s === "day" ? "Day 🌅" : "Night 🌚"),
  toggle: () => {
    wlsunsetToggle()
    nightLight.value = nightLight.value === "day" ? "night" : "day"
  },
  connection: [nightLight, () => nightLight.value === "day"],
})
