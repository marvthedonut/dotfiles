import os
import subprocess

directory = 'config'



def main():

    symlinks = get_symlinks()
    make_dirs(symlinks)
    gen_symlinks(symlinks)
    packages = get_packages()
    install_packages(packages)

def install_packages(packages):
    os.system("sudo pacman -Sy --noconfirm --needed " + " ".join(packages))

def get_packages():
    with open("packages") as f:
        contents = f.read()
    return contents.split("\n")

def gen_symlinks(symlinks):
    for symlink in symlinks:
        link = symlinks[symlink]
        print(f"Trying to create symbolic link for {symlink}")
        if os.path.exists(symlink) and not os.path.islink(symlink):
            os.system(f"sudo rm -rf {symlink}")

        if link[1]:
            subprocess.call(["sudo", "ln", "-s", os.path.join(link[0],os.path.basename(symlink)), symlink])
        else:
            subprocess.call(["sudo", "ln", "-s", link[0], symlink])


def make_dirs(symlinks):
    for link in symlinks:
        symlink = symlinks[link]
        path = os.path.dirname(link)
        if not os.path.exists(path):
            print(f"Making path {path}")
            subprocess.call(["sudo", "mkdir", "-p", path])
            subprocess.call(["sudo", "chown", "-R", os.environ.get("USER") + ":", path])



def get_symlinks():
    # List all documented symlinks
    print("Serializing symlinks")
    with open("symlinks") as f:
        symlink = [link for link in f.read().split("\n") if link.strip()]
    
    symlinks = {}
    for link in symlink:
        link_parsed = link.replace("~", os.path.expanduser("~")).split(" ")
        # First in array is where in config it is 
        # Second is whether it is not a folder
        symlinks[link_parsed[2]] = [link_parsed[1], link_parsed[0] == "True"]
        print(f"Got symlink {link_parsed[2]}")
    print(f"Serialized {len(symlinks)} symlinks")
    return symlinks

    


if __name__ == "__main__":
    main()
