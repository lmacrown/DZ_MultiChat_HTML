package Post;

import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class BoardFile implements Serializable {
	private static final long serialVersionUID = -6675626554487766989L;

	private int f_id;
	private int number;
	private String org_name;
	private String real_name ; ;
	private String content_type;
	private long   length;
   
}
   
