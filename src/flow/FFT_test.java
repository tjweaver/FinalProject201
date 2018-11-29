package flow;
import java.io.File;
import java.util.ArrayList;

public class FFT_test {
	public static void main(String [] args)
	{
		SongAnalyzer sa = new SongAnalyzer();
		//testing the analyze function for analyzing a library of songs
		//this will take a very long time to run, possibly 2 or 3 hours depending on the number of songs
		//we only used around 140 songs in the library to test playlist making abilities. 
		//we do not have access to the commercial music databases that companies like spotify have so 
		//we did the best we could by using songs that are on our own music libraries and also getting song samples from spotify with a converter
		
		
		 // this test will cover many test cases in one full sweep, this will cover mp3 conversion to raw data, and the MFCC song analysis alogrithm with DTW overlay
		 
		File dir = new File("media/");
		File[] directoryListing = dir.listFiles();
		if(directoryListing != null)
		{
			for(File child: directoryListing)
			{
				sa.analyze("media/" + child.getName());
			}
		}
		//next we will test certain songs and see what playlist comes out
		//two songs that sound similar
		
		ArrayList<String> playlist = null;
		playlist = sa.PlaylistBuilder("Gone"); //should expect similar laid back soft melody songs like fleetwood mac and kenney chesney
		for(int i = 0; i<playlist.size(); i++)
		{
			System.out.println(playlist.get(i));
		}
		//next
		playlist = sa.PlaylistBuilder("Boogie With Stu"); //should expect similar rock type songs with a good blues/jazz vibe
		for(int i = 0; i<playlist.size(); i++)
		{
			System.out.println(playlist.get(i));
		}
		//next
		playlist = sa.PlaylistBuilder("Summer, Highland Falls"); //should expect similar soft up beat melody songs with majority of piano
		for(int i = 0; i<playlist.size(); i++)
		{
			System.out.println(playlist.get(i));
		}
		//next
		playlist = sa.PlaylistBuilder(""); //should expect similar laid back soft melody songs like fleetwood mac and kenney chesney
		for(int i = 0; i<playlist.size(); i++)
		{
			System.out.println(playlist.get(i));
		}
	}
}
