import os
import sys


def main():
    args = sys.argv
    os.chdir(os.path.dirname(__file__))
    if len(args) <= 1:
        print("Pass in the file you want to symlink")
        return
    if len(args) <= 2:
        print("Pass in the category")
        return
    path = os.path.abspath(args[1])
    category = os.path.abspath(os.path.join("config", args[2]))

    if not (os.path.exists and (os.path.isfile(path) or os.path.isdir(path))):
        print("Not valid path")
        return

    if not (os.path.exists(category) and os.path.isdir(category)):
        print("Invalid category")
        return

    filename = os.path.basename(path)

    with open("symlinks", "r+") as file:
        contents = file.read()
        file.seek(0)
        if not path in contents:
            contents = contents + "\n" + f"{os.path.isfile(path)} {category} {path}"
            file.write("\n".join([word for word in contents.split("\n") if word.strip()]))
        else:
            print("Symlink is already documented")
            return
    if os.path.islink(path):
        print("File is already a symlink")
        return
    os.system(f"sudo mv {path} {os.path.join(category, filename)}")
    os.system(f"sudo ln -s {os.path.join(category, filename)} {path}")


if __name__ == "__main__":
    main()
