import SystemPackage

@main
struct Cat {
    public static func main() throws {
        let argv = CommandLine.arguments
        let argc = CommandLine.arguments.count

        let buf = UnsafeMutableRawBufferPointer.allocate(byteCount: 4096, alignment: 0)
        var fd: FileDescriptor = FileDescriptor.standardInput

        if argc != 2 {
            fatalError("Usage: \(argv[0]) [ file ]")
        } else {
            do {
                fd = try FileDescriptor.open(argv[1], .readOnly)
            } catch {
                fatalError("cannot open \(argv[1]): \(error)")
            }

            do {
                let bytes = try fd.read(into: buf)
                try fd.close()
                let _ = try FileDescriptor.standardOutput.writeAll(buf[..<bytes])
                buf.deallocate()
            } catch {
                fatalError("Error: \(error)")
            }
        }
    }
}
