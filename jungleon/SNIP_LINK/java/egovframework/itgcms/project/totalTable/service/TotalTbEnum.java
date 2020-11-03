package egovframework.itgcms.project.totalTable.service;

public class TotalTbEnum {

	public enum TOTALTB_GRSTEP {
		GRSTEP01("1", "창업 아이템 사업화"),
		GRSTEP02("2", "생존과 성장"),
		GRSTEP03("3", "혁신성장"),
		GRSTEP04("4", "도약*글로벌 진출"),
		;

		private String value;
		private String name;

		public String getValue() {
			return this.value;
		}
		public String getName() {
			return this.name;
		}

		private TOTALTB_GRSTEP(String value, String name) {
			this.value = value;
			this.name = name;
		}
	}
}
