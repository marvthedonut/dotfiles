import os
import subprocess

directory = 'config'



def main():
    symlinks = get_symlinks()
    make_dirs(symlinks)
    gen_symlinks(symlinks)

def gen_symlinks(symlinks):
    for symlink in symlinks:
        link = symlinks[symlink]
        print(f"Trying to create symbolic link for {symlink}")
        if os.path.exists(symlink):
            os.system(f"sudo rm {symlink}")

        subprocess.call(["sudo","ln", "-s", os.path.join(link[0],os.path.basename(symlink)), symlink])


def make_dirs(symlinks):
    for link in symlinks:
        symlink = symlinks[link]
        path = os.path.dirname(link)
        print(os.path.dirname(link))
        if not os.path.exists(path):
            print(f"Making path {path}")
            os.system(f"sudo mkdir -p {path}")



def get_symlinks():
    # List all documented symlinks
    print("Serializing symlinks")
    with open("symlinks") as f:
        symlink = [link for link in f.read().split("\n") if link.strip()]
    
    symlinks = {}
    for link in symlink:
        link_parsed = link.replace("~", os.path.expanduser("~")).split(" ")
        symlinks[link_parsed[2]] = [link_parsed[1], link_parsed[0] == "True"]
        print(f"Got symlink {link_parsed[2]}")
    print(f"Serialized {len(symlinks)} symlinks")
    return symlinks

    


if __name__ == "__main__":
    main()
