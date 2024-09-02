use std::{env, fs, io::Write, process::{Command, Stdio}};

fn main() {
    // Use directory executable is in so that it is constant

    let mut current_dir = env::current_exe().unwrap();
    current_dir.pop();

    assert!(current_dir.to_str().unwrap().ends_with("/scripts/script_parser"));

    let _  = env::set_current_dir(current_dir);

    let contents = fs::read_to_string("../scripts").unwrap();

    let data = serialize_file(&contents);

    let list = list_display_names(data);

    let mut rofi = Command::new("rofi")
        .arg("-sep")
        .arg("|")
        .arg("-dmenu")
        .arg("-p")
        .arg("Scripts")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn().unwrap();

    let mut stdin = rofi.stdin.take().unwrap();
    stdin.write(list.as_bytes()).unwrap();
    
    let stdout = rofi.wait_with_output().unwrap();

    println!("{}", String::from_utf8_lossy(&stdout.stdout));
}

fn serialize_file(contents: &str) -> Vec<Vec<&str>> {
    let lines = contents.split("\n");
    let mut buffer = Vec::new();

    for line in lines {
        if !line.is_empty() {
            let data: Vec<&str> = line.split(";").collect();

            assert_eq!(data.len(), 2);

            buffer.push(data);
        }
    }

    return buffer;
}

fn list_display_names(data: Vec<Vec<&str>>) -> String {
    let mut iter = data.into_iter().peekable();
    let mut list = String::new();


    while let Some(pair) = iter.next() {
        list.push_str(pair[1]);

        if !iter.peek().is_none() {
            list.push_str("|");
        }
    }

    return list;
}
