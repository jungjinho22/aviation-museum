package egovframework.aviation.metadata.vo;

public class Material2VO {
	private String material2_code_idx;
	private String material1_code_idx;
	private String material2_nm;
	private String seq;
	private String enabled;
	private String reg_user;
	private String reg_date;
	private String mod_user;
	private String mod_date;
	
	public String getMaterial2_code_idx() {
		return material2_code_idx;
	}
	public void setMaterial2_code_idx(String material2_code_idx) {
		this.material2_code_idx = material2_code_idx;
	}
	public String getMaterial1_code_idx() {
		return material1_code_idx;
	}
	public void setMaterial1_code_idx(String material1_code_idx) {
		this.material1_code_idx = material1_code_idx;
	}
	public String getMaterial2_nm() {
		return material2_nm;
	}
	public void setMaterial2_nm(String material2_nm) {
		this.material2_nm = material2_nm;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public String getReg_user() {
		return reg_user;
	}
	public void setReg_user(String reg_user) {
		this.reg_user = reg_user;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getMod_user() {
		return mod_user;
	}
	public void setMod_user(String mod_user) {
		this.mod_user = mod_user;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	
	@Override
	public String toString() {
		return "Material2VO [material2_code_idx=" + material2_code_idx + ", material1_code_idx=" + material1_code_idx
				+ ", material2_nm=" + material2_nm + ", seq=" + seq + ", enabled=" + enabled + ", reg_user=" + reg_user
				+ ", reg_date=" + reg_date + ", mod_user=" + mod_user + ", mod_date=" + mod_date + "]";
	}
	
}
