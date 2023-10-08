import os
import subprocess

directory = 'config'



def main():
    # Iterate through all config files
    for dirname in os.listdir(directory):
        d = os.path.join(directory, dirname)
        if os.path.isdir(d):
            print(f"Initializing {d}")
            symlinks = get_symlinks(d)
            make_dirs(symlinks)
            gen_symlinks(symlinks)

def gen_symlinks(symlinks):
    for symlink in symlinks:
        link = symlinks[symlink]
        print(f"Trying to create symbolic link for {link}")
        if os.path.exists(link):
            os.system(f"sudo rm {link}")

        subprocess.call(["sudo","ln", "-s", symlink, link])


def make_dirs(symlinks):
    for link in symlinks:
        symlink = symlinks[link]
        path = os.path.dirname(symlink)
        if not os.path.exists(path):
            print(f"Making path {path}")
            os.system(f"sudo mkdir -p {path}")



def get_symlinks(directory):
    # List all documented symlinks
    with open(directory + "/symlink") as f:
        symlink = f.read().split("\n")
    symlink.pop()
    symlinks = {}
    for link in symlink:
        link_parsed = link.split(" ")
        symlinks[os.path.abspath(os.path.join(directory,link_parsed[0]))] = link_parsed[1].replace("$HOME", os.path.expanduser("~"))
    print(f"Got symlinks for {os.path.abspath(directory)}")
    return symlinks

    


if __name__ == "__main__":
    main()
