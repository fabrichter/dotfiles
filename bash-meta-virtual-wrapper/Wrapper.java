import java.io.IOException;
public class Wrapper {
    public static void main(String[] args) throws IOException, InterruptedException {
       String exec = String.join(" ", args);
       ProcessBuilder pb = new ProcessBuilder("bash -c \"" + exec + "\"");
       pb.inheritIO();
       Process p = pb.start();
       System.exit(p.waitFor());
   }
}
