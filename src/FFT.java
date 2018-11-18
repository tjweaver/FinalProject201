import java.io.File;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;
import java.util.Vector;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.SourceDataLine;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.jtransforms.dct.DoubleDCT_1D;
import org.jtransforms.fft.DoubleFFT_1D;
import org.tritonus.share.sampled.file.TAudioFileFormat;





public class FFT {

public static void main(String[] args)
{
	test one = new test();
	/*one.analyze("Down the Road.mp3");
	one.analyze("Colder Weather.mp3");
	one.analyze("Demons.mp3");
	one.analyze("Lance s Song.mp3");
	one.analyze("One Step Up.mp3");*/
	/*System.out.println(one.compare("Jolene", "Ocean"));
	System.out.println(one.compare("Jolene", "Sthlm Sunset"));
	System.out.println(one.compare("Jolene", "Demons"));
	System.out.println(one.compare("Jolene", "Colder Weather"));
	System.out.println(one.compare("Jolene", "One Step Up"));
	System.out.println(one.compare("Jolene", "Down the Road"));
	System.out.println(one.compare("Jolene", "Lance's Song"));
	*/
	//System.out.println(one.compare("Jolene", "Ocean"));
	//System.out.println(one.compare("Sthlm Sunset", "Ocean"));
	/*File dir = new File("media/");
	File[] directoryListing = dir.listFiles();
	if(directoryListing != null)
	{
		for(File child: directoryListing)
		{
			one.analyze("media/" + child.getName());
		}
	}*/
	ArrayList<String> playlist = null;
	playlist = one.PlaylistBuilder("Ooh! My Head");
	for(int i = 0; i<playlist.size(); i++)
	{
		System.out.println(playlist.get(i));
	}
	
}

}

class test {
public void analyze(String filename)
{
  try {
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
	Class.forName("com.mysql.jdbc.Driver"); //this is could be done in a config file
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?user=root&password=root&useSSL=false");	//this is a URI uniform resource identifier
	
	
	
	
    File file = new File(filename);
    AudioInputStream in= AudioSystem.getAudioInputStream(file);
    AudioInputStream din = null;
    AudioFormat baseFormat = in.getFormat();
    AudioFormat decodedFormat = new AudioFormat(AudioFormat.Encoding.PCM_SIGNED,
                                                                                  baseFormat.getSampleRate(),
                                                                                  16,
                                                                                  baseFormat.getChannels(),
                                                                                  baseFormat.getChannels() * 2,
                                                                                  baseFormat.getSampleRate(),
                                                                                  false);
    din = AudioSystem.getAudioInputStream(decodedFormat, in);
    // Play now.
    int k = 0;
    int l = 0;
    int count = 0;
    
    //System.out.println(din.available() + " "+AudioSystem.getAudioFileFormat(file).getFrameLength() + " " + decodedFormat.getFrameSize() + " " + decodedFormat.getSampleSizeInBits() );
    AudioFileFormat baseFileFormat = null;
    AudioFormat baseeFormat = null;
    baseFileFormat = AudioSystem.getAudioFileFormat(file);
    baseeFormat = baseFileFormat.getFormat();
    
    
    //***************************
    // TAudioFileFormat properties
    String title = null;
    String author = null;
    String album = null;
    if (baseFileFormat instanceof TAudioFileFormat)
    {
        Map properties = ((TAudioFileFormat)baseFileFormat).properties();
        String key = "title"; 
        title = (String) properties.get(key);
        key = "author";
        author =(String) properties.get(key);
        key = "album";
        album = (String) properties.get(key);
        
        PreparedStatement p = conn.prepareStatement("INSERT INTO song_details(title, artist, album) VALUES (?,?,?)");
        p.setString(1, title);
        p.setString(2, author);
        p.setString(3, album);
        p.executeUpdate();
        //ps3 = conn.prepareStatement("INSERT INTO event_table(Event_name, userID, Event_time, Event_Date, uniqueID) VALUES (?,?,?,?,?)");
        
        
    }
    //end properities
    //****************************
    
    
    
    
    
    
    
    System.out.println("Beginning: " + title);
    //*************************************************************
    //Begin MFCC analysis
    PreparedStatement p0 = conn.prepareStatement("SELECT songID FROM song_details WHERE title=?");

    p0.setString(1, title);
    
    rs = p0.executeQuery();
    		//ps = conn.prepareStatement("SELECT e.uniqueID FROM event_table e WHERE e.uniqueID=? AND e.userID=? "); //check if there is an event already with that unique ID
    PreparedStatement p1 = conn.prepareStatement("INSERT INTO frames(songID, co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
    if(rs.next()) {
    	
    	p1.setString(1, rs.getString("songID"));
    	
    }
    
    byte[] data = new byte[2*1102];
    double[] datadouble = new double[2*1102];
    Vector<double[]> result = new Vector<double[]>();
    int nBytesRead = 0;
    DoubleFFT_1D FFT = new DoubleFFT_1D(1102);
    double[] powerdouble = new double[2*1102];
    int N = 1102;
    double[] mels = new double[28];
    double[] freq = new double[28];
    double lb = (double) 282.728;
    double incr = (double) 103.15;
    double sum = lb;
    //fills the Mel array with the 26 filters
    for(int i = 0; i < mels.length; i++)
    {
    	mels[i] = sum;
    	sum += incr;
    }
    //fills the frequency array with the 26 filters
    for(int i = 0; i < mels.length; i++)
    {
    	freq[i] = (double) (700*(Math.exp(mels[i]/1125) - 1));
    	//System.out.println(freq[i]);
    }
    /*
     * bin = numpy.floor((nfft+1)*mel2hz(melpoints)/samplerate)

    fbank = numpy.zeros([nfilt,nfft//2+1])
    for j in range(0,nfilt):
        for i in range(int(bin[j]), int(bin[j+1])):
            fbank[j,i] = (i - bin[j]) / (bin[j+1]-bin[j])
        for i in range(int(bin[j+1]), int(bin[j+2])):
			fbank[j,i] = (bin[j+2]-i) / (bin[j+2]-bin[j+1])
     * 
     */
    double[] fft_bin = new double[28];
    double[][] filterBanks = new double[28][N];
    for(int i = 0; i < fft_bin.length; i++)
    {
    	fft_bin[i] = (double) Math.floor((N+1)*freq[i]/44100);
    	//System.out.println(fft_bin[i]);
    }
    for(int i = 0; i < filterBanks.length-2; i++ )
    {
    	for(int j = (int)fft_bin[i]; j < (int)fft_bin[i+1]; j++)
    	{
    		filterBanks[i][j] = (j - fft_bin[i]) / (fft_bin[i+1] - fft_bin[i]);
    		//System.out.println(filterBanks[i][j]);
    	}
    	for(int j = (int)fft_bin[i+1]; j < (int)fft_bin[i+2]; j++)
    	{
    		filterBanks[i][j] = (fft_bin[i+2] - j) / (fft_bin[i+2] - fft_bin[i+1]);
    		//System.out.println(filterBanks[i][j]);
    	}
    }
    //done with the 26 filters, they are stored in the filterbanks matrix and ready to use in MFCC

    
    
    //FileWriter write = new FileWriter("output.txt");
    
    while (nBytesRead != -1)
    {
        nBytesRead = din.read(data, 0, data.length);
        for(int i = 0; i < data.length; i++)
        {
        	datadouble[i] = (double)(data[i]);
        }
        if (nBytesRead != -1)
        {
        	FFT.realForwardFull(datadouble);
        	for(int i = 0; i<datadouble.length; i++)
        	{
        		powerdouble[i] = (Math.pow(N, -1))*(Math.abs(datadouble[i]) * Math.abs(datadouble[i]));
        		//System.out.println(powerdouble[i]);
        		       		
        	}
        	double[] energy = new double[28];
    		
    	    for(int ii = 0; ii < 28; ii++)
    	    {
    	    	double energy_sum = 0;
    	    	for(int j = 0; j < N; j++ )
    	    	{
    	    		energy_sum += powerdouble[j] * filterBanks[ii][j];
    	    	}
    	    	energy[ii] = energy_sum;
    	    	//System.out.println(energy[ii]);
    	    }
    	    //take the log of the energies
    	    for(int j = 0; j < energy.length; j++ )
    	    {
    	    	if(energy[j] == 0) energy[j] = 1;
    	    	energy[j] = Math.log(energy[j]);
    	    	//System.out.println(energy[j]);
    	    } 
    	    //take the DCT of the log energies

    	    DoubleDCT_1D DCT = new DoubleDCT_1D(28);
    	    
    	    DCT.forward(energy, false);
    	    //put the coefficients into the database

    	    for(int j = 0; j < 12; j++) 
    	    {
    	    	p1.setDouble(j+2, energy[j]);
    	    
    	    }
    	    p1.executeUpdate();
    	    


        }
         
    }
    
    
    
    //End MFCC analysis
    //*************************************************************

	
    System.out.println("done with: " + title);
    
    
    
    
    

    
    in.close();
    conn.close();
    
  } catch (UnsupportedAudioFileException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (IOException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} 
}





public double compare(String name1, String name2)
{
	double sum = 0;
	try {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSet frames1 = null;
		ResultSet frames2 = null;	
		ResultSet count1 = null;
		ResultSet count2 = null;
		Class.forName("com.mysql.jdbc.Driver"); //this is could be done in a config file
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?user=root&password=root&useSSL=false");	//this is a URI uniform resource identifier
		PreparedStatement p0 = conn.prepareStatement("SELECT songID FROM song_details WHERE title=?");
		PreparedStatement p00 = conn.prepareStatement("SELECT songID FROM song_details WHERE title=?");
		p0.setString(1, name1);
		rs = p0.executeQuery();
		p00.setString(1, name2);
		rs2 = p00.executeQuery();
		PreparedStatement p1 = conn.prepareStatement("SELECT co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12 FROM frames WHERE songID=? ");
		PreparedStatement p2 = conn.prepareStatement("SELECT co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12 FROM frames WHERE songID=? ");
		if(rs.next()) p1.setInt(1, rs.getInt(1));
		if(rs2.next()) p2.setInt(1, rs2.getInt("songID"));
		
		PreparedStatement p3 = conn.prepareStatement("SELECT count(*) From project.frames where songID=?");
		PreparedStatement p33 = conn.prepareStatement("SELECT count(*) From project.frames where songID=?");
		p3.setInt(1, rs.getInt("songID"));
		count1 = p3.executeQuery();
		p33.setInt(1, rs2.getInt("songID"));
		count2 = p33.executeQuery();
		
		double[][] matrix1 = null;
		double[][] matrix2 = null;
		frames1 = p1.executeQuery();
		frames2 = p2.executeQuery();
		if(count1.next())  matrix1 = new double[count1.getInt(1)][12];
		if(count2.next()) matrix2 = new double[count2.getInt(1)][12];
		
		
		if(frames1.next()) {
			for(int i = 0; i<count1.getInt(1)-1 ; i++)
			{
				frames1.next();
				for(int j = 0; j<12; j++)
				{
					matrix1[i][j] = frames1.getInt(j+1);
					//System.out.println(matrix1[i][j]);
				}
			}
		}
		if(frames2.next()) {
			for(int i = 0; i<count2.getInt(1)-1 ; i++)
			{
				frames2.next();
				for(int j = 0; j<12; j++)
				{
					matrix2[i][j] = frames2.getInt(j+1);
				}
			}
		}
		//matrix comparison going to happen next

		
		if(count1.getInt(1) <= count2.getInt(1))
		{
			for(int i = 0; i < count1.getInt(1); i++)
			{
				for(int j = 0; j < 12; j++)
				{
					sum += Math.abs(matrix1[i][j] - matrix2[i][j]);
				}
			}
		}
		else
		{
			for(int i = 0; i < count2.getInt(1) ; i++)
			{
				for(int j = 0; j < 12; j++)
				{
					 sum += Math.abs(matrix1[i][j] - matrix2[i][j]);
				}
			}
		}
		return sum;
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return sum;
	
	
}




public ArrayList<String> PlaylistBuilder(String songname)
{
	ArrayList< String> playlist = new ArrayList<String>();
	ArrayList<Double> range = new ArrayList<Double>();
	ArrayList< String> playlist_final = new ArrayList<String>();
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet frames1 = null;
	ResultSet frames2 = null;	
	ResultSet count1 = null;
	ResultSet count2 = null;
	try {
	Class.forName("com.mysql.jdbc.Driver"); //this is could be done in a config file
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?user=root&password=root&useSSL=false");	//this is a URI uniform resource identifier
	PreparedStatement p0 = conn.prepareStatement("SELECT genre FROM song_details WHERE title=?");
	PreparedStatement p00 = conn.prepareStatement("SELECT title FROM song_details WHERE title !=? AND genre=?");
	p0.setString(1, songname);
	p00.setString(1, songname);
	rs = p0.executeQuery();
	rs.next();
	p00.setString(2, rs.getString(1) );
	rs2 = p00.executeQuery();
	double sum = 0;
	while(rs2.next())
	{
		sum = compare(songname, rs2.getString("title"));
		playlist.add(rs2.getString("title"));
		range.add(sum);
		sum = 0;
		
	}
	//sort the array in ascending order
	/*for(int i = 0; i < playlist.size(); i++)
	{
		System.out.println(playlist.get(i) + ": " + range.get(i));
	}*/
	for(int i = 0; i < playlist.size(); i++)
	{
		for(int j = 0; j < playlist.size() -1; j++)
		{
			if(range.get(j) > range.get(j+1))
			{
				double temp = range.get(j);
				range.set(j, range.get(j+1));
				range.set(j+1, temp);
				String tempp = playlist.get(j);
				playlist.set(j, playlist.get(j+1));
				playlist.set(j+1, tempp);
					
			}
		}
	}
	/*int median = playlist.size()/2;
	for(int i = median; i < median + 6; i++)
	{
		playlist_final.add(playlist.get(i));
	}
	for(int i = median -6; i < median; i++)
	{
		playlist_final.add(playlist.get(i));
	}*/
	for(int i = 2; i < 14; i++)
	{
		playlist_final.add(playlist.get(i));
	}
	return playlist_final;
	
	//sort the playlist
	
	
	
	
	
	
	
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return playlist_final;
}


} 
