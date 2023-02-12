import SystemPackage

@main
struct cat {
    static func usage(progname: String) {
        fatalError("Usage: \(progname) [ file ]")
    }
    public static func main() throws {
        let argv = CommandLine.arguments
        let argc = CommandLine.arguments.count

        let buf = UnsafeMutableRawBufferPointer.allocate(byteCount: 4096, alignment: 0)
        var fd: FileDescriptor = FileDescriptor.standardInput

        if argc != 2 {
            usage(progname: argv[0])
        } else {
            do {
                fd = try FileDescriptor.open(argv[1], .readOnly)
            } catch {
                fatalError("cannot open \(argv[1]): \(error)")
            }

            do {
                let _ = try fd.read(into: buf)
                let _ = try FileDescriptor.standardOutput.write(UnsafeRawBufferPointer(buf))
            } catch {
                fatalError("Error: \(error)")
            }
        }
    }
}
