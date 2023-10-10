import os
import sys

def main():
    args = sys.argv
    if len(args) <= 1:
        print("Pass in the file you want to symlink")
        return
    path = args[1]
    category = os.path.abspath(os.path.join("config", args[2]))
    
    if not (os.path.exists and (os.path.isfile(path) or os.path.isdir(path))):
        print("Not valid path")
        return
    
    if not (os.path.exists(category) and os.path.isdir(category)):
        print("Invalid category")
        return
    
    filename = os.path.basename(path)
    
    os.rename(path, os.path.join(category, filename))
    os.system(f"sudo ln -s {os.path.join(category, filename)} {path}")
    with open("symlinks", "r+") as file:
        contents = file.read()
        file.write("\n" + f"{os.path.isfile(path)} {category} {path}")


if __name__ == "__main__":
    main()
