# sha256_everything

**sha256_everything** is a Ruby gem that hashes every single file in a specified directory and outputs the result in a neatly formatted TXT file.

## Example Output

```
File Hierarchy                       SHA256 Hash

├── .gitignore                       1e152031a561398186651a06090f3b08e0c0abb486fd516524e93ec4e57c1cc3
├── .rspec                           06245e25d7cf46b4fbde27b5faa0df0d4110e11918eeb5848de4ab2aff897b59
├── CODE_OF_CONDUCT.md               f02b057ee644a4f7e722156b8497d6b8932101ca2083425d829790797d6f538f
├── Gemfile                          81d62526d923ef3a2b684a4dfa9b3a76eebe03a0fc037268f2763165a52b03a4
├── lib
│   ├── sha256_everything
│   │   ├── application.rb           54b5b8713c27fbc2d61af29a2f7851dc174da80339735013c645a619eb710e5d
│   │   ├── cli.rb                   d5f9993b29c6adc1569718d17ae10692eb40393019f34673993a3a37b6eaa1d0
│   │   ├── file_collector.rb        095e96607d636b7392a6201799dc5b54e8bd5a4b0251534091bdb22a16eb0ebd
│   │   ├── file_hasher.rb           24baecab98a3143a5f292bcd8bb3e85ea29472f0552b65eec08d7581825d1f65
│   │   ├── output_writer.rb         bb7830388ca1f7ab4faf641508cef101691809b83c3bc0496644c288cac8d3a8
│   │   ├── tree_generator.rb        448522451bb7a8b52e5bf4f797e3e97a3b443729b660d4b0e1b8e2bf07d0f794
│   │   └── version.rb               0507bfc041b1fff564afc4fd5e7c293d84b8eb8e53fbd398735c9d6a7625dca3
│   └── sha256_everything.rb         a458e489aab5eecc4cb328b5ea04e5a2f4cad5872579f62a7faf4ceec10b9011

```

## Features

- **Recursive Processing:** Scans and hashes all files (including hidden ones) while skipping internal directories (like `.git`).
- **Live Progress:** A dynamic progress bar keeps you informed as each file is hashed.
- **Formatted Output:** Produces a prettified result showing the file hierarchy and corresponding SHA256 hashes.

## Installation

Install it directly via:

```bash
gem install sha256_everything
```

## Usage

After installation, you can run the gem's command from your terminal:

```bash
sha256_everything
```

### Options

- `-f [NAME]`, `--filename [NAME]` — Specify the output file name (default: hashes.txt).
- `-d`, `--display_here` — Display the file hierarchy in the terminal.
- `-h`, `--help` — Show help and usage instructions.

## Testing

   ```bash
   bundle install
   bundle exec rspec
   ```

## Contributing

Contributions, bug reports, and pull requests are welcome!
Feel free to check issues or submit your own at [GitHub Issues](https://github.com/jibril-tapiador/sha256_everything/issues).

## License

This gem is available as open source under the terms of the [MIT License](LICENSE).

## Authors

- **Jibril Tapiador** - [tapiador@jib.is](mailto:tapiador@jib.is)

## Acknowledgements

- Thanks to [ruby-progressbar](https://github.com/jfelchner/ruby-progressbar) for the progress bar implementation.
