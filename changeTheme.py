import sys
import os


def main(args):
    os.chdir(os.path.dirname(__file__))
    if len(args) <= 1:
        print("Pass in wallpaper to change to")
        return
    wallpaperPath = os.path.abspath("config/wallpapers/" + args[1] + ".png")
    colorsPath = os.path.abspath("config/polybar/colors/" + args[1] + ".ini")
    if not os.path.exists(wallpaperPath) or "lockscreen.png" == args[1]:
        print("Not a wallpaper")
        return

    if os.path.exists(os.path.expanduser("~/Downloads/wallpaper.png")):
        print("Removing existng wallpaper")
        os.remove(os.path.expanduser("~/Downloads/wallpaper.png"))
    if os.path.exists("/etc/polybar/colors.ini"):
        print("Removing colors symlink")
        os.remove("/etc/polybar/colors.ini")

    os.system(f"sudo ln -s {wallpaperPath} ~/Downloads/wallpaper.png")
    os.system(f"sudo ln -s {colorsPath} /etc/polybar/colors.ini")

    os.system("./lockscreen-gen.sh")

    os.system("i3 restart")


if __name__ == "__main__":
    main(sys.argv)
