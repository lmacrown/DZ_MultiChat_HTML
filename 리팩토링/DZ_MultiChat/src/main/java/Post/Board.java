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
public class Board implements Serializable {
	private static final long serialVersionUID = 1449132512754742285L;
	private String number;
	private String parentNo;
	private String title;
	private String content;
	private String writeId;;
	private Date writeDate;
	private int viewCount;
	private int likeCount;
	private int disLikeCount;

	public Board() {
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Board other = (Board) obj;
		return Objects.equals(number, other.number);
	}

	@Override
	public int hashCode() {
		return Objects.hash(title);
	}

	

}
