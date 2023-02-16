import SystemPackage

@main
struct Echo {
    static func unescape(_ p: String) {
        let p: [String] = p.map { String($0) }
        debugPrint(p)
        for idx in 0..<p.count {
            if p[idx] != "\\" || p[idx + 1] == "\0" {
                print(#line)
                print(#"\\"# == p[idx])
                print(p[idx], terminator: "")
                continue
            }

            if p[idx] == #"\\"# {
                print("\\", terminator: "")
                continue
            }
            print(p[idx], terminator: "")
        }
    }

    static func main() {
        let argv = CommandLine.arguments
        let argc = CommandLine.arguments.count
        guard argc > 1 else { print(""); return }

        let args: [String] = Array(argv[1...])
        for p in args {
            if p != args[0] {
                print(" ", terminator: "")
            }

            unescape(p)
        }


        print("")
    }
}
