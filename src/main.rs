use smol::io::AsyncWriteExt;

fn main() {
    let n = smol::block_on(write_file());

    std::process::exit(n as i32)
}

async fn write_file() -> usize {
    let json = b"Now you see me";
    let mut file = smol::fs::File::create("now-you-dont.txt").await.unwrap();

    let mut written = 0;
    while written < json.len() {
        written += file.write(&json[written..]).await.unwrap();
    }

    // Uncommenting the following line fixes the issue
    // std::thread::sleep(std::time::Duration::from_millis(1));

    written
}
